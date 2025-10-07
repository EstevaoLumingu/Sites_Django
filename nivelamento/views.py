from datetime import timezone
from pyexpat.errors import messages
from django.shortcuts import render, get_object_or_404, redirect
from notificacoes.utils import notificar
from users.models import CustomUser
from .models import Nivelamento, PedidoMatricula
from courses.models import Course
from django.contrib.auth.decorators import user_passes_test
from .models import QuizPergunta, QuizResposta, ResultadoTeste
from .forms import QuizRespostaForm
from django.contrib.auth.decorators import login_required
from django.forms import modelformset_factory
from .forms import PerguntaNivelamentoForm, RespostaForm
from django.contrib import messages
from django.db.models import Min
from django.db.models import Count
from classroom.models import Classroom
from .models import PedidoMatricula
from django.db.models import Q
from django.utils import timezone  


@login_required
def fazer_teste_view(request, curso_id):
    curso = get_object_or_404(Course, id=curso_id)
    
# 1. Obter 1 ID único por texto da pergunta, por curso
    ids_distintos = (
        QuizPergunta.objects
        .filter(curso=curso)
        .values('pergunta')  # agrupar por pergunta textual
        .annotate(id_min=Min('id'))  # pega o menor ID de cada grupo
        .values_list('id_min', flat=True)
    )

    # 2. Selecionar 10 aleatórias entre essas distintas
    perguntas = QuizPergunta.objects.filter(id__in=ids_distintos).order_by('?')[:10]

    if request.method == 'POST':
        pontuacao = 0

        for pergunta in perguntas:
            resposta_id = request.POST.get(f'pergunta_{pergunta.id}')
            if resposta_id:
                try:
                    resposta = QuizResposta.objects.get(id=resposta_id)
                    if resposta.correta:
                        pontuacao += 1
                except QuizResposta.DoesNotExist:
                    continue

        # Avaliar nível
        if pontuacao >= 8:
            nivel = 'avancado'
        elif pontuacao >= 6:
            nivel = 'intermedio'
        elif pontuacao >= 4:
            nivel = 'Pre-Intermédio'
        else:
            nivel = 'iniciante'

        # Criar resultado
        resultado = ResultadoTeste.objects.create(
            aluno=request.user,
            curso=curso,
            pontuacao=pontuacao,
            nivel_atribuido=nivel
        )

        # Notificar aluno com link para ver resultado
        notificar(
            request.user,
            f"🧠 Teste de nível finalizado! Teu nível atribuído para o curso '{curso.nome}' foi: {nivel.upper()}",
            f"/nivelamento/resultado/{resultado.id}/"
        )

        return redirect('resultado_teste', resultado_id=resultado.id)

    return render(request, 'nivelamento/teste.html', {
        'curso': curso,
        'perguntas': perguntas,
    })

@login_required
def resultado_teste_view(request, resultado_id):
    resultado = get_object_or_404(ResultadoTeste, id=resultado_id, aluno=request.user)
    curso = resultado.curso

    nivel_requerido = curso.classroom_set.first().nivel if curso.classroom_set.exists() else 'iniciante'
    apto = resultado.nivel_atribuido == nivel_requerido

    if request.method == "POST":
        acao = request.POST.get('acao')

        if acao == "submeter":
            # redirecionar para página de pagamento
            return redirect('pagina_pagamento', curso_id=curso.id, resultado_id=resultado.id)

        elif acao == "repetir":
            return redirect('fazer_teste', curso_id=curso.id)

    return render(request, 'nivelamento/resultado.html', {
        'resultado': resultado,
        'curso': curso,
        'apto': apto,
        'nivel_requerido': nivel_requerido
    })


from django.core.paginator import Paginator

@login_required
@user_passes_test(lambda u: u.is_admin or u.categoria == 'professor')
def listar_pedidos_view(request):
    curso_id = request.GET.get("curso")
    status = request.GET.get("status")

    pedidos_qs = PedidoMatricula.objects.all().select_related('curso', 'aluno', 'resultado_teste')

    if curso_id:
        pedidos_qs = pedidos_qs.filter(curso_id=curso_id)

    if status == "aprovado":
        pedidos_qs = pedidos_qs.filter(avaliado=True, aprovado=True)
    elif status == "rejeitado":
        pedidos_qs = pedidos_qs.filter(avaliado=True, aprovado=False)
    elif status == "pendente":
        pedidos_qs = pedidos_qs.filter(avaliado=False)

    cursos = Course.objects.all()
    total_pedidos = pedidos_qs.count() 

    # Paginação
    paginator = Paginator(pedidos_qs.order_by("-data_solicitacao"), 10)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    return render(request, "nivelamento/pedidos.html", {
        "pedidos": page_obj,
        "cursos": cursos,
        "curso_selecionado": curso_id,
        "status_selecionado": status,
        "total_pedidos": total_pedidos
    })


@login_required
def ver_resultado_detalhado_view(request, resultado_id):
    from users.models import CustomUser
    from .models import RespostaAluno

    resultado = get_object_or_404(ResultadoTeste, id=resultado_id)

    # Se não for o dono e não for admin/professor → acesso negado
    if resultado.aluno != request.user and not (request.user.is_admin or request.user.categoria == 'professor'):
        return HttpResponseForbidden("Você não tem permissão para ver esse resultado.")

    respostas = RespostaAluno.objects.filter(resultado=resultado).select_related('pergunta')

    corretas = []
    erradas = []

    for r in respostas:
        if r.alternativa_respondida == r.pergunta.alternativa_correta:
            corretas.append(r)
        else:
            erradas.append(r)

    return render(request, "nivelamento/resultado_detalhado.html", {
        "resultado": resultado,
        "corretas": corretas,
        "erradas": erradas
    })


@login_required
@user_passes_test(lambda u: u.is_admin or u.categoria == 'professor')
def avaliar_pedido_view(request, pedido_id):
    pedido = get_object_or_404(PedidoMatricula, id=pedido_id)

    if request.method == "POST":
        acao = request.POST.get("acao")

        pedido.avaliado = True

        if acao == "aprovar":
            pedido.aprovado = True
            pedido.avaliado_pagamento_em = timezone.now()

            sala_disponivel = Classroom.objects.filter(curso=pedido.curso).annotate(num_alunos=Count('alunos')).filter(num_alunos__lt=5).first()

            if sala_disponivel:
                sala_disponivel.alunos.add(pedido.aluno)
                notificar(pedido.aluno, f"✅ Matrícula aprovada e alocado na sala '{sala_disponivel.titulo}'", "/painel_aluno/")
            else:
                notificar(pedido.aluno, "✅ Matrícula aprovada, aguarde alocação em sala.", "/painel_aluno/")

        else:
            pedido.aprovado = False
            notificar(pedido.aluno, "❌ Pagamento recusado. Corrija e tente novamente.", "/painel_aluno/")

        pedido.save()
        return redirect('listar_pedidos')

    return render(request, "nivelamento/avaliar_pedido.html", {
        "pedido": pedido
    })


@login_required
@user_passes_test(lambda u: u.is_admin)
def listar_perguntas_view(request):
    perguntas = QuizPergunta.objects.prefetch_related('respostas').all()
    cursos = Course.objects.all()

    curso_id = request.GET.get('curso')
    nivel = request.GET.get('nivel')

    if curso_id:
        perguntas = perguntas.filter(curso__id=curso_id)
    if nivel:
        perguntas = perguntas.filter(nivel=nivel)

    return render(request, 'adminpanel/nivelamento/listar_perguntas.html', {
        'perguntas': perguntas,
        'cursos': cursos,
        'filtro_curso': curso_id,
        'filtro_nivel': nivel
    })


@login_required
@user_passes_test(lambda u: u.is_admin)
def criar_pergunta_nivelamento_view(request):
    RespostaFormSet = modelformset_factory(QuizResposta, form=RespostaForm, extra=4, max_num=4, validate_max=True)

    if request.method == 'POST':
        pergunta_form = PerguntaNivelamentoForm(request.POST)
        resposta_formset = RespostaFormSet(request.POST, queryset=QuizResposta.objects.none())

        if pergunta_form.is_valid() and resposta_formset.is_valid():
            pergunta = pergunta_form.save()
            for resposta_form in resposta_formset:
                if resposta_form.cleaned_data:
                    resposta = resposta_form.save(commit=False)
                    resposta.pergunta = pergunta
                    resposta.save()

            messages.success(request, "Pergunta e respostas criadas com sucesso!")
            return redirect('listar_perguntas_nivelamento')
        else:
            messages.error(request, "Erro ao salvar a pergunta. Verifique os campos.")
    else:
        pergunta_form = PerguntaNivelamentoForm()
        resposta_formset = RespostaFormSet(queryset=QuizResposta.objects.none())

    return render(request, 'adminpanel/nivelamento/criar_pergunta.html', {
        'pergunta_form': pergunta_form,
        'resposta_formset': resposta_formset,
        'titulo': 'Nova Pergunta'
    })
    
@login_required
@user_passes_test(lambda u: u.is_admin)
def editar_pergunta_admin_view(request, pergunta_id):
    pergunta = get_object_or_404(QuizPergunta, id=pergunta_id)
    RespostaFormSet = modelformset_factory(QuizResposta, form=RespostaForm, extra=0, can_delete=True)

    if request.method == 'POST':
        pergunta_form = PerguntaNivelamentoForm(request.POST, instance=pergunta)
        resposta_formset = RespostaFormSet(request.POST, queryset=pergunta.respostas.all())

        if pergunta_form.is_valid() and resposta_formset.is_valid():
            pergunta = pergunta_form.save()
            for form in resposta_formset:
                if form.cleaned_data:
                    if form.cleaned_data.get('DELETE'):
                        form.instance.delete()
                    else:
                        resposta = form.save(commit=False)
                        resposta.pergunta = pergunta
                        resposta.save()

            messages.success(request, "Pergunta atualizada com sucesso!")
            return redirect('listar_perguntas_nivelamento')
        else:
            messages.error(request, "Erro ao atualizar a pergunta.")
    else:
        pergunta_form = PerguntaNivelamentoForm(instance=pergunta)
        resposta_formset = RespostaFormSet(queryset=pergunta.respostas.all())

    return render(request, 'adminpanel/nivelamento/criar_pergunta.html', {
        'pergunta_form': pergunta_form,
        'resposta_formset': resposta_formset,
        'titulo': 'Editar Pergunta'
    })


@login_required
@user_passes_test(lambda u: u.is_admin)
def excluir_pergunta_admin_view(request, pergunta_id):
    pergunta = get_object_or_404(QuizPergunta, id=pergunta_id)
    pergunta.delete()
    return redirect('listar_perguntas_nivelamento')      

import random
from django.http import HttpResponseForbidden, JsonResponse

from django.http import JsonResponse
from django.shortcuts import get_object_or_404
from nivelamento.models import QuizPergunta

@login_required
@user_passes_test(lambda u: u.is_admin)
def gerar_pergunta_ia_view(request):
    curso = request.GET.get('curso')
    nivel = request.GET.get('nivel')

    if not curso or not nivel:
        return JsonResponse({'erro': 'Curso ou nível não especificado.'}, status=400)

    try:
        curso_obj = Course.objects.get(id=curso)
    except Course.DoesNotExist:
        return JsonResponse({'erro': 'Curso inválido.'}, status=404)

    pergunta = QuizPergunta.objects.filter(curso=curso_obj, nivel=nivel).order_by('?').first()

    if not pergunta:
        return JsonResponse({'erro': 'Sem perguntas para esse curso e nível.'}, status=404)

    return JsonResponse({
        'pergunta': pergunta.pergunta,
        'respostas': [
            {'texto': r.texto, 'correta': r.correta}
            for r in pergunta.respostas.all()
        ]
    })

from financeiro.models import ConfiguracaoFinanceira
from courses.models import PlanoPrecoCurso
from django.contrib import messages
from django.shortcuts import render, redirect, get_object_or_404
from nivelamento.models import ResultadoTeste, PedidoMatricula
from courses.models import PlanoPrecoCurso

@login_required
def pagina_pagamento_view(request, curso_id, resultado_id):
    curso = get_object_or_404(Course, id=curso_id)
    resultado = get_object_or_404(ResultadoTeste, id=resultado_id, aluno=request.user)

    planos = PlanoPrecoCurso.objects.filter(curso=curso)
    configuracao = ConfiguracaoFinanceira.objects.last()

    if request.method == "POST":
        plano_id = request.POST.get("plano")
        comprovativo = request.FILES.get("comprovativo")

        # Validação: plano obrigatório
        if not plano_id or not comprovativo:
            messages.error(request, "Por favor selecione um plano e envie o comprovativo.")
            return redirect("pagina_pagamento", curso_id=curso.id, resultado_id=resultado.id)

        try:
            plano = PlanoPrecoCurso.objects.get(id=plano_id, curso=curso)
        except PlanoPrecoCurso.DoesNotExist:
            messages.error(request, "Plano inválido para este curso.")
            return redirect("pagina_pagamento", curso_id=curso.id, resultado_id=resultado.id)

        # Criar pedido
        PedidoMatricula.objects.create(
            aluno=request.user,
            curso=curso,
            resultado_teste=resultado,
            plano=plano,
            comprovativo=comprovativo,
            pagamento_enviado=True
        )

        # Notificar admins
        for adm in CustomUser.objects.filter(is_admin=True):
            notificar(adm, f"💳 Novo pagamento enviado para o curso {curso.nome} ({plano})", "/nivelamento/pedidos/")

        messages.success(request, "📤 Comprovativo enviado. Aguarde a aprovação do administrador.")
        return redirect("painel_aluno")

    return render(request, "nivelamento/pagamento.html", {
        "curso": curso,
        "resultado": resultado,
        "planos": planos,
        "configuracao": configuracao
    })

