from django.contrib.auth.decorators import login_required
from django.http import HttpResponseForbidden

from classroom.models import Classroom
from .models import Course, Enrollment
from django.shortcuts import render, redirect
from django.contrib import messages
from .forms import CriarCursoForm
from django import forms
from notificacoes.utils import notificar
from users.models import CustomUser


def lista_cursos_view(request):
    cursos = Course.objects.all()
    return render(request, 'courses/lista_cursos.html', {'cursos': cursos})


from django.contrib.auth.decorators import login_required
from django.shortcuts import render
from django.db.models import Count, Q
from .models import Course

from classroom.models import Classroom
from nivelamento.models import PedidoMatricula

from django.db.models import Count
from django.contrib.auth.decorators import login_required
from django.shortcuts import render
from classroom.models import Classroom


@login_required
def cursos_disponiveis_view(request):
    salas = Classroom.objects.select_related('curso', 'professor') \
        .annotate(num_alunos=Count('alunos')) \
        .order_by('curso__nome', 'nivel')

    # Matrículas aprovadas do aluno
    matriculas = PedidoMatricula.objects.filter(
        aluno=request.user,
        aprovado=True
    ).select_related('resultado_teste')

    # Preparar set com (curso_id, nivel)
    matriculas_ids = set(
        (m.curso_id, m.resultado_teste.nivel_atribuido) for m in matriculas
    )

    # Salas onde o aluno já está atribuído diretamente
    salas_do_aluno_ids = set(
        (sala.curso_id, sala.nivel)
        for sala in request.user.salas_matriculadas.all()
    )

    # União dos dois conjuntos
    ja_matriculado = matriculas_ids.union(salas_do_aluno_ids)

    return render(request, 'courses/disponiveis.html', {
        'salas': salas,
        'matriculas_ids': ja_matriculado
    })



@login_required
def matricular_view(request, curso_id):
    curso = Course.objects.get(pk=curso_id)
    enrollment, created = Enrollment.objects.get_or_create(aluno=request.user, curso=curso)

    if created:
        # Notifica o próprio aluno
        notificar(request.user, f"Estás agora matriculado no curso {curso.nome}.")
        
        # Notifica o admin
        admins = CustomUser.objects.filter(is_admin=True)
        for admin in admins:
            notificar(admin, f"{request.user.get_full_name()} matriculou-se no curso {curso.nome}.", "/painel-admin/")

        messages.success(request, f"Matriculado no curso {curso.nome} com sucesso!")
    else:
        messages.info(request, f"Já estás matriculado no curso {curso.nome}.")
    
    return redirect('painel_aluno')

@login_required
def criar_curso_view(request):
    if request.user.categoria != 'professor':
        return HttpResponseForbidden()

    if request.method == 'POST':
        form = CriarCursoForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('painel_salas_professor')
    else:
        form = CriarCursoForm()
    
    return render(request, 'courses/criar_curso.html', {'form': form})
