from pyexpat.errors import messages
from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.decorators import login_required
from notificacoes.utils import notificar
from .decorators import admin_required
from courses.models import Course
from courses.forms import CriarCursoForm
from users.models import CustomUser
from users.forms import CustomUserAdminEditForm
from users.forms import CustomUserCreationForm
from classroom.models import Classroom
from classroom.forms import CriarSalaForm
from lessons.models import LiveLesson
import json
from django.db.models.functions import TruncMonth
from django.db.models import Count
from comunicacao.models import MensagemContato, AvaliacaoProfessor
from nivelamento.models import QuizPergunta
from notificacoes.models import Notificacao
from django.db.models import Q

@login_required
@admin_required
def listar_mensagens_contato_view(request):
    status = request.GET.get("status")

    mensagens = MensagemContato.objects.all().order_by("-data_envio")

    if status == "lidas":
        mensagens = mensagens.filter(lida=True)
    elif status == "nao_lidas":
        mensagens = mensagens.filter(lida=False)

    return render(request, "adminpanel/mensagens.html", {
        "mensagens": mensagens,
        "status": status
    })

@login_required
@admin_required
def marcar_mensagem_lida_view(request, mensagem_id):
    mensagem = get_object_or_404(MensagemContato, id=mensagem_id)
    mensagem.lida = True
    mensagem.save()
    messages.success(request, "Mensagem marcada como lida.")
    return redirect("listar_mensagens_contato")


from comunicacao.models import MensagemContato, AvaliacaoProfessor
from nivelamento.models import PedidoMatricula

@login_required
@admin_required
def painel_admin_home(request):
    total_pedidos_pendentes = PedidoMatricula.objects.filter(avaliado=False).count()
    total_mensagens_nao_lidas = MensagemContato.objects.filter(lida=False).count()
    total_avaliacoes = AvaliacaoProfessor.objects.count()  # ou filtre por "não vistas" se preferir

    return render(request, 'adminpanel/dashboard.html', {
        'pedidos_novos': total_pedidos_pendentes,
        'mensagens_novas': total_mensagens_nao_lidas,
        'avaliacoes_novas': total_avaliacoes,
        # pode adicionar outros contadores
    })


@login_required
@admin_required
def listar_cursos_view(request):
    cursos = Course.objects.all()
    return render(request, 'adminpanel/cursos/listar.html', {'cursos': cursos})

from django.contrib import messages

from django.db import IntegrityError

@login_required
@admin_required
def criar_curso_admin_view(request):
    if request.method == 'POST':
        form = CriarCursoForm(request.POST, request.FILES)
        if form.is_valid():
            try:
                curso = form.save()
                usuarios = CustomUser.objects.all()
                for user in usuarios:
                    notificar(
                        user,
                        f"📚 Um novo curso '{curso.nome}' foi criado e já está disponível para matrícula.",
                        "/painel_aluno/" if user.categoria == 'estudante' else "/painel-salas/"
                    )
                messages.success(request, "Curso criado com sucesso!")
                return redirect('listar_cursos_admin')

            except IntegrityError:
                messages.error(request, "Já existe um curso com esse nome. Por favor escolha outro.")

    else:
        form = CriarCursoForm()

    return render(request, 'adminpanel/cursos/formulario.html', {
        'form': form,
        'titulo': 'Criar Curso'
    })

from django.db import IntegrityError

@login_required
@admin_required
def editar_curso_admin_view(request, curso_id):
    curso = get_object_or_404(Course, id=curso_id)

    if request.method == 'POST':
        form = CriarCursoForm(request.POST, request.FILES, instance=curso)
        if form.is_valid():
            try:
                curso = form.save()
                usuarios = CustomUser.objects.all()
                for user in usuarios:
                    notificar(
                        user,
                        f"🔧 O curso '{curso.nome}' foi atualizado, confira as novidades.",
                        "/painel_aluno/" if user.categoria == 'estudante' else "/painel-salas/"
                    )
                messages.success(request, "Curso atualizado com sucesso.")
                return redirect('listar_cursos_admin')

            except IntegrityError:
                messages.error(request, "Já existe um curso com esse nome. Por favor escolha outro.")

    else:
        form = CriarCursoForm(instance=curso)

    return render(request, 'adminpanel/cursos/formulario.html', {
        'form': form,
        'titulo': 'Editar Curso'
    })

@login_required
@admin_required
def excluir_curso_admin_view(request, curso_id):
    curso = get_object_or_404(Course, id=curso_id)
    nome = curso.nome
    try:
        curso.delete()
        messages.success(request, f"O curso '{nome}' foi removido com sucesso.")
    except Exception:
        messages.error(request, f"Erro ao excluir o curso '{nome}'.")
        return redirect('listar_cursos_admin')

    usuarios = CustomUser.objects.all()
    for user in usuarios:
        notificar(
            user,
            f"⚠️ O curso '{nome}' foi removido da plataforma.",
            "/painel_aluno/" if user.categoria == 'estudante' else "/painel-salas/"
        )

    return redirect('listar_cursos_admin')



@login_required
@admin_required
def listar_usuarios_view(request):
    usuarios = CustomUser.objects.all()
    return render(request, 'adminpanel/usuarios/listar.html', {'usuarios': usuarios})

@login_required
@admin_required
def editar_usuario_admin_view(request, user_id):
    user = get_object_or_404(CustomUser, id=user_id)

    if request.method == 'POST':
        form = CustomUserAdminEditForm(request.POST, instance=user)
        if form.is_valid():
            form.save()
            return redirect('listar_usuarios_admin')
    else:
        form = CustomUserAdminEditForm(instance=user)

    return render(request, 'adminpanel/usuarios/formulario.html', {'form': form, 'user_obj': user})

@login_required
@admin_required
def alternar_ativo_view(request, user_id):
    user = get_object_or_404(CustomUser, id=user_id)
    user.is_active = not user.is_active
    user.save()

    if user.is_active:
        notificar(user, "✅ A tua conta foi reativada pelo administrador.")
    else:
        notificar(user, "🚫 A tua conta foi desativada pelo administrador.")

    return redirect('listar_usuarios_admin')


@login_required
@admin_required
def excluir_usuario_view(request, user_id):
    user = get_object_or_404(CustomUser, id=user_id)
    user.delete()
    return redirect('listar_usuarios_admin')


@login_required
@admin_required
def criar_usuario_admin_view(request):
    if request.method == 'POST':
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('listar_usuarios_admin')
    else:
        form = CustomUserCreationForm()

    return render(request, 'adminpanel/usuarios/formulario.html', {
        'form': form,
        'titulo': 'Criar Novo Utilizador'
    })


@login_required
@admin_required
def listar_salas_admin_view(request):
    salas = Classroom.objects.select_related('curso', 'professor').all()
    return render(request, 'adminpanel/salas/listar.html', {'salas': salas})


@login_required
@admin_required
def criar_sala_admin_view(request):
    if request.method == 'POST':
        form = CriarSalaForm(request.POST)
        if form.is_valid():
            sala = form.save()
            if sala.professor:
                notificar(
                    sala.professor,
                    f"👨‍🏫 Foste atribuído(a) à sala '{sala.titulo}' para o curso {sala.curso.nome}.",
                    "/painel-salas/"
                )
            return redirect('listar_salas_admin')
    else:
        form = CriarSalaForm()

    for field in form.fields.values():
        field.widget.attrs['class'] = 'form-control'

    return render(request, 'adminpanel/salas/formulario.html', {'form': form, 'titulo': 'Criar Nova Sala'})


@login_required
@admin_required
def editar_sala_admin_view(request, sala_id):
    sala = get_object_or_404(Classroom, id=sala_id)
    if request.method == 'POST':
        form = CriarSalaForm(request.POST, instance=sala)
        if form.is_valid():
            sala = form.save()

            # Notificar professor
            if sala.professor:
                notificar(
                    sala.professor,
                    f"📝 A sala '{sala.titulo}' foi atualizada. Verifica os detalhes no painel.",
                    "/painel-salas/"
                )

            # Notificar alunos
            for aluno in sala.alunos.all():
                notificar(
                    aluno,
                    f"⚠️ A sala '{sala.titulo}' da qual fazes parte foi atualizada.",
                    "/painel_aluno/"
                )

            return redirect('listar_salas_admin')
    else:
        form = CriarSalaForm(instance=sala)

    return render(request, 'adminpanel/salas/formulario.html', {'form': form, 'titulo': 'Editar Sala'})


@login_required
@admin_required
def excluir_sala_admin_view(request, sala_id):
    sala = get_object_or_404(Classroom, id=sala_id)
    professor = sala.professor
    nome_sala = sala.titulo

    # Guardar alunos antes de apagar
    alunos = list(sala.alunos.all())

    sala.delete()

    # Notificar professor
    if professor:
        notificar(
            professor,
            f"❌ A sala '{nome_sala}' atribuída a ti foi excluída pelo administrador.",
            "/painel-salas/"
        )

    # Notificar alunos
    for aluno in alunos:
        notificar(
            aluno,
            f"⚠️ A sala '{nome_sala}' onde estavas matriculado foi excluída.",
            "/painel_aluno/"
        )

    return redirect('listar_salas_admin')


@login_required
@admin_required
def estatisticas_admin_view(request):
    from users.models import CustomUser
    from courses.models import Course
    from classroom.models import Classroom
    from lessons.models import LiveLesson

    total_usuarios = CustomUser.objects.count()
    total_estudantes = CustomUser.objects.filter(categoria='estudante').count()
    total_professores = CustomUser.objects.filter(categoria='professor').count()
    total_cursos = Course.objects.count()
    total_salas = Classroom.objects.count()
    total_aulas = LiveLesson.objects.count()

    # 📊 Usuários por mês
    users_by_month = (
        CustomUser.objects.annotate(month=TruncMonth('date_joined'))
        .values('month')
        .annotate(count=Count('id'))
        .order_by('month')
    )

    chart_labels = [u['month'].strftime('%b %Y') for u in users_by_month]
    chart_data = [u['count'] for u in users_by_month]

    context = {
        'total_usuarios': total_usuarios,
        'total_estudantes': total_estudantes,
        'total_professores': total_professores,
        'total_cursos': total_cursos,
        'total_salas': total_salas,
        'total_aulas': total_aulas,
        'chart_labels': json.dumps(chart_labels),
        'chart_data': json.dumps(chart_data),
    }

    return render(request, 'adminpanel/estatisticas.html', context)


@login_required
def gerir_testes_nivelamento_view(request):
    cursos = Course.objects.all().order_by('nome')
    perguntas = QuizPergunta.objects.all().order_by('curso', 'nivel')

    return render(request, 'adminpanel/nivelamento/testes_nivelamento.html', {
        'cursos': cursos,
        'perguntas': perguntas,
    })


def listar_mensagens_contato_view(request):
    mensagens = MensagemContato.objects.all().order_by('-data_envio')
    return render(request, 'adminpanel/mensagens.html', {'mensagens': mensagens})

def avaliar_professores_admin_view(request):
    avaliacoes = AvaliacaoProfessor.objects.select_related('professor', 'aluno').order_by('-data')
    return render(request, 'adminpanel/avaliacoes.html', {'avaliacoes': avaliacoes})
