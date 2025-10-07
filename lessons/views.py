from pyexpat.errors import messages
from django.shortcuts import get_object_or_404, redirect, render
from notificacoes.utils import notificar
from .models import LiveLesson
from django.contrib.auth.decorators import login_required, user_passes_test
from classroom.models import Classroom
from django.http import HttpResponseForbidden
from django.http import HttpResponseBadRequest, HttpResponseForbidden
from django.shortcuts import render, redirect, get_object_or_404
from .forms import LiveLessonForm
from .models import ParticipacaoAluno



@login_required
def entrar_na_aula_view(request, slug_sala):
    aula = get_object_or_404(LiveLesson, slug_sala=slug_sala)
    if request.user.categoria == 'estudante':
        ParticipacaoAluno.objects.get_or_create(
            aula=aula,
            aluno=request.user,
            defaults={'presente': True}
        )

    return render(request, 'lessons/aovivo.html', {'aula': aula})



def is_professor(user):
    return user.is_authenticated and user.tipo_acesso == 'professor'
from users.decorators import professor_required

@professor_required
def painel_aulas_professor_view(request):
    if request.user.categoria != 'professor':
        return HttpResponseForbidden("Acesso restrito a professores.")
    
    aulas = LiveLesson.objects.filter(criado_por=request.user)
    return render(request, 'lessons/painel_sala.html', {'aulas': aulas})


from django.http import HttpResponseBadRequest
from django.shortcuts import redirect, get_object_or_404, render
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from lessons.forms import LiveLessonForm
from lessons.models import LiveLesson
from classroom.models import Classroom


@login_required
def criar_aula_view(request):
    if request.user.categoria != 'professor':
        return HttpResponseBadRequest("Acesso não autorizado.")

    sala_id = request.GET.get('sala_id')
    if not sala_id or not sala_id.isdigit():
        return HttpResponseBadRequest("ID da sala inválido.")

    sala_inicial = get_object_or_404(Classroom, id=sala_id, professor=request.user)

    # Para armazenar sugestão gerada
    sugestao_titulo = None
    conflito = False

    if request.method == 'POST':
        form = LiveLessonForm(request.POST, professor=request.user)

        if form.is_valid():
            titulo = form.cleaned_data['titulo']
            aula_existente = LiveLesson.objects.filter(
                classroom=sala_inicial,
                titulo__iexact=titulo
            ).exists()

            # Se já existe e não veio confirmação ainda
            if aula_existente and 'confirmar_renomear' not in request.POST:
                conflito = True

                # Gera sugestão automaticamente com "(parte X)"
                base = titulo
                count = 2
                while LiveLesson.objects.filter(
                    classroom=sala_inicial,
                    titulo__iexact=f"{base} (parte {count})"
                ).exists():
                    count += 1
                sugestao_titulo = f"{base} (parte {count})"

                # Mensagem e formulário continuam sem salvar
                messages.warning(request, f"A aula '{titulo}' já existe. Desejas renomear automaticamente como '{sugestao_titulo}'?")
            elif 'confirmar_renomear' in request.POST:
                # Auto-rename aprovado pelo usuário
                titulo_original = request.POST.get('titulo_original')
                titulo_renomeado = request.POST.get('sugestao_titulo')

                form = LiveLessonForm(
                    {
                        **request.POST,
                        'titulo': titulo_renomeado
                    },
                    professor=request.user
                )
                if form.is_valid():
                    aula = form.save(commit=False)
                    aula.criado_por = request.user
                    aula.save()

                    for aluno in aula.classroom.alunos.all():
                        notificar(
                            aluno,
                            f"📢 Nova aula criada: '{aula.titulo}' na sala '{aula.classroom.titulo}'.",
                            f"/aulas/painel/aluno/"
                        )
                    return redirect('painel_sala', sala_id=sala_inicial.id)

            else:
                # Nenhum conflito, pode salvar normalmente
                aula = form.save(commit=False)
                aula.criado_por = request.user
                aula.save()

                for aluno in aula.classroom.alunos.all():
                    notificar(
                        aluno,
                        f"📢 Nova aula criada: '{aula.titulo}' na sala '{aula.classroom.titulo}'.",
                        f"/aulas/painel/aluno/"
                    )

                return redirect('painel_sala', sala_id=sala_inicial.id)
    else:
        form = LiveLessonForm(professor=request.user, sala_inicial=sala_inicial)

    return render(request, 'lessons/criar_aula.html', {
        'form': form,
        'sugestao_titulo': sugestao_titulo,
        'conflito': conflito,
        'titulo_original': request.POST.get('titulo', '') if request.method == 'POST' else ''
    })


@login_required
def painel_salas_professor(request):
    if request.user.categoria != 'professor':
        return HttpResponseForbidden("Acesso negado.")
    
    salas = Classroom.objects.filter(professor=request.user)
    return render(request, 'lessons/painel_salas_professor.html', {'salas': salas})


@login_required
def aulas_por_sala_view(request, sala_id):
    sala = get_object_or_404(Classroom, id=sala_id)

    # ✅ Autorização personalizada
    if request.user.categoria == 'professor':
        if sala.professor != request.user:
            return HttpResponseForbidden("Não és responsável por esta sala.")
    elif request.user.categoria == 'estudante':
        if request.user not in sala.alunos.all():
            return HttpResponseForbidden("Não pertences a esta sala.")
    else:
        return HttpResponseForbidden("Perfil de utilizador inválido.")

    aulas = LiveLesson.objects.filter(classroom=sala).order_by('-horario')

    return render(request, 'lessons/aulas_por_sala.html', {
        'sala': sala,
        'aulas': aulas
    })

    
    
@login_required
def editar_aula_view(request, aula_id):
    aula = get_object_or_404(LiveLesson, id=aula_id, criado_por=request.user)

    if request.method == 'POST':
        form = LiveLessonForm(request.POST, instance=aula, professor=request.user)
        if form.is_valid():
            aula = form.save()

            for aluno in aula.classroom.alunos.all():
                notificar(
                    aluno,
                    f"🔄 Aula atualizada: '{aula.titulo}' na sala '{aula.classroom.titulo}'.",
                    f"/aulas/painel/aluno/"
                )

            return redirect('aulas_por_sala', sala_id=aula.classroom.id)
    else:
        form = LiveLessonForm(instance=aula, professor=request.user, sala_inicial=aula.classroom)

    return render(request, 'lessons/editar_aula.html', {'form': form, 'aula': aula})

@login_required
def remover_aula_view(request, aula_id):
    aula = get_object_or_404(LiveLesson, id=aula_id, criado_por=request.user)
    sala_id = aula.classroom.id
    titulo = aula.titulo

    # Notificar antes de apagar
    for aluno in aula.classroom.alunos.all():
        notificar(
            aluno,
            f"❌ Aula cancelada: '{titulo}' foi removida da sala '{aula.classroom.titulo}'.",
            "/aulas/painel/aluno/"
        )

    aula.delete()
    return redirect('aulas_por_sala', sala_id=sala_id)

@login_required
def avaliar_participacao_view(request, aula_id):
    aula = get_object_or_404(LiveLesson, id=aula_id, criado_por=request.user)
    alunos = aula.classroom.alunos.all()

    if request.method == 'POST':
        for aluno in alunos:
            key = f'avaliacao_{aluno.id}'
            avaliacao = request.POST.get(key)
            if avaliacao:
                participacao, _ = ParticipacaoAluno.objects.get_or_create(aula=aula, aluno=aluno)
                participacao.avaliacao = avaliacao
                participacao.presente = True  # Marca como presente se está sendo avaliado
                participacao.save()

        messages.success(request, "Avaliação registrada com sucesso.")
        return redirect('aulas_por_sala', sala_id=aula.classroom.id)

    avaliacoes = ParticipacaoAluno.objects.filter(aula=aula).select_related('aluno')
    avaliacoes_dict = {a.aluno.id: a.avaliacao for a in avaliacoes}

    return render(request, 'lessons/avaliar_participacao.html', {
        'aula': aula,
        'alunos': alunos,
        'avaliacoes': avaliacoes_dict,
    })
    
    
@login_required
def painel_sala_view(request, sala_id):
    sala = get_object_or_404(Classroom, id=sala_id)

    # ✅ Verifica se o usuário pertence a essa sala
    if request.user.categoria == 'estudante':
        if request.user not in sala.alunos.all():
            return HttpResponseForbidden("Não tens acesso a esta sala.")
    elif request.user.categoria == 'professor':
        if sala.professor != request.user:
            return HttpResponseForbidden("Não és o responsável por esta sala.")
    else:
        return HttpResponseForbidden("Tipo de utilizador inválido.")

    aulas = sala.aulas.order_by('-horario')
    participacoes = {}

    if request.user.categoria == 'estudante':
        participacoes = {
            part.aula.id: part
            for part in ParticipacaoAluno.objects.filter(
                aluno=request.user,
                aula__classroom=sala
            )
        }

    return render(request, 'lessons/painel_sala.html', {
        'sala': sala,
        'aulas': aulas,
        'participacoes': participacoes,
    })


@login_required
def marcar_presenca_view(request, aula_id):
    aula = get_object_or_404(LiveLesson, id=aula_id)

    participacao, created = ParticipacaoAluno.objects.get_or_create(
        aula=aula,
        aluno=request.user,
        defaults={'presente': True}
    )
    if not created:
        participacao.presente = True
        participacao.save()

    return redirect(aula.get_jitsi_url())  # ir direto pra Jitsi

from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.http import HttpResponseForbidden, FileResponse
from .models import MaterialDidatico
from .forms import MaterialDidaticoForm
from users.models import CustomUser
import os

@login_required
def painel_materiais_view(request, sala_id):
    sala = get_object_or_404(Classroom, id=sala_id)
    return render(request, 'lessons/materiais/painel.html', {'sala': sala})



from .forms import MaterialDidaticoForm

@login_required
def meus_materiais_view(request):
    materiais = MaterialDidatico.objects.filter(criado_por=request.user).order_by('-criado_em')
    form = MaterialDidaticoForm(user=request.user)  # <-- ADICIONE ISSO

    return render(request, 'lessons/materiais/meus_materiais.html', {
        'materiais': materiais,
        'form': form  # <-- ENVIE O FORMULÁRIO PARA O TEMPLATE
    })



@login_required
def materiais_recebidos_view(request):
    if request.user.categoria == 'professor':
        # Professor vê materiais de seus alunos (exceto os que ele enviou)
        salas = Classroom.objects.filter(professor=request.user)
        materiais = MaterialDidatico.objects.filter(sala__in=salas).exclude(criado_por=request.user)

    elif request.user.categoria == 'estudante':
        # Aluno vê apenas os materiais enviados pelo professor da(s) sua(s) sala(s)
        salas = request.user.salas_matriculadas.all()
        materiais = MaterialDidatico.objects.filter(
            sala__in=salas,
            criado_por__categoria='professor'
        )
    else:
        return HttpResponseForbidden("Acesso negado.")

    return render(request, 'lessons/materiais/materiais_recebidos.html', {
        'materiais': materiais
    })




@login_required
def enviar_material_view(request):
    if request.method == 'POST':
        form = MaterialDidaticoForm(request.POST, request.FILES, user=request.user)
        if form.is_valid():
            material = form.save(commit=False)
            material.criado_por = request.user
            material.save()

            # 🔔 Notificar professor se for aluno
            if request.user.categoria == 'estudante' and material.sala:
                notificar(
                    material.sala.professor,
                    f"📥 Novo material enviado por {request.user.get_full_name()} na sala {material.sala.titulo}",
                    f"/aulas/materiais/{material.sala.id}/"
                )

            messages.success(request, "Material enviado com sucesso!")
            return redirect('painel_materiais', sala_id=material.sala.id)

    else:
        form = MaterialDidaticoForm(user=request.user)

    return render(request, 'lessons/materiais/enviar_material.html', {'form': form})



@login_required
def baixar_material_view(request, material_id):
    material = get_object_or_404(MaterialDidatico, id=material_id)

    if request.user != material.criado_por and request.user not in material.sala.alunos.all() and request.user != material.sala.professor:
        return HttpResponseForbidden("Acesso negado.")

    return FileResponse(material.arquivo.open('rb'), as_attachment=True, filename=os.path.basename(material.arquivo.name))

@login_required
def deletar_material_view(request, material_id):
    material = get_object_or_404(MaterialDidatico, id=material_id)

    if material.autor != request.user:
        messages.error(request, "❌ Não tens permissão para eliminar este material.")
        return redirect('materiais_sala', sala_id=material.sala.id)

    sala_id = material.sala.id
    material.delete()
    messages.success(request, "🗑️ Material removido.")
    return redirect('materiais_sala', sala_id=sala_id)      

from django.http import JsonResponse

@login_required
def ajax_aulas_por_sala(request, sala_id):
    aulas = LiveLesson.objects.filter(classroom_id=sala_id).order_by('-horario')
    data = [{'id': a.id, 'titulo': a.titulo} for a in aulas]
    return JsonResponse({'aulas': data})
