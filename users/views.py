from datetime import timezone
from django.contrib.auth import login, logout, authenticate
from django.contrib.auth.decorators import login_required
from .forms import CustomUserCreationForm, CustomLoginForm
from django.http import HttpResponseForbidden
from django.contrib import messages
from classroom.models import Classroom
from lessons.models import LiveLesson
from courses.models import Enrollment
from notificacoes.models import Notificacao
from django.shortcuts import render, redirect, get_object_or_404
from .forms import PerfilUpdateForm
from django.contrib.auth.forms import PasswordChangeForm
from django.contrib.auth import update_session_auth_hash
from django.contrib import messages
from django.shortcuts import redirect
from django.contrib.auth.decorators import login_required

def register_view(request):
    if request.method == 'POST':
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()
            login(request, user)
            return redirect('home')
    else:
        # Define categoria padrão como '' ou 'estudante' para garantir
        form = CustomUserCreationForm(initial={'categoria': ''})
    return render(request, 'users/register.html', {'form': form})



def login_view(request):
    if request.user.is_authenticated:
        # Já está logado → redireciona direto
        return redirect('home')  # ou painel correto, se quiseres refinar

    if request.method == 'POST':
        form = CustomLoginForm(data=request.POST)
        if form.is_valid():
            user = form.get_user()
            login(request, user)

            # Redirecionar consoante o tipo de utilizador
            if user.tipo_acesso == 'admin' or user.is_superuser or user.is_admin:
                return redirect('home')
            elif user.tipo_acesso == 'professor':
                return redirect('home')
            elif user.tipo_acesso == 'padrao':
                return redirect('home')
            else:
                messages.warning(request, "Tipo de acesso desconhecido.")
                return redirect('home')
    else:
        form = CustomLoginForm()

    return render(request, 'users/login.html', {'form': form})


def logout_view(request):
    logout(request)
    return redirect('login')


@login_required
def perfil_view(request):
    user = request.user
    if request.method == 'POST':
        form = PerfilUpdateForm(request.POST, request.FILES, instance=user)
        if form.is_valid():
            form.save()
            messages.success(request, 'Perfil atualizado com sucesso!')
            return redirect('meu_perfil')
    else:
        form = PerfilUpdateForm(instance=user)

    return render(request, 'users/perfil.html', {'form': form, 'user_obj': user})



@login_required
def alterar_senha_view(request):
    if request.method == 'POST':
        form = PasswordChangeForm(request.user, request.POST)
        if form.is_valid():
            user = form.save()
            update_session_auth_hash(request, user)  # Mantém o usuário logado
            messages.success(request, 'Senha alterada com sucesso.')
        else:
            messages.error(request, 'Erro ao alterar a senha. Verifique os dados.')
    return redirect('meu_perfil')


@login_required
def dashboard_professor_view(request):
    if request.user.tipo_acesso != 'professor':
        return HttpResponseForbidden("Acesso negado.")
    return render(request, 'users/dashboard_professor.html')

@login_required
def dashboard_estudante_view(request):
    if request.user.tipo_acesso != 'padrao':
        return HttpResponseForbidden("Acesso negado.")
    return render(request, 'users/dashboard_estudante.html')

from django.utils import timezone 

@login_required
def painel_aluno_view(request):
    salas = request.user.salas_matriculadas.select_related("curso", "professor").all()
    aulas = LiveLesson.objects.filter(
        classroom__in=salas,
        horario__gte=timezone.now() 
    ).order_by('horario')

    return render(request, 'users/painel_aluno.html', {
        'salas': salas,
        'aulas': aulas,
    })


@login_required
def lista_notificacoes_view(request):
    notificacoes = request.user.notificacoes.all().order_by('-data')
    return render(request, 'users/notificacoes/lista.html', {'notificacoes': notificacoes})


@login_required
def marcar_lida_view(request, notificacao_id):
    notificacao = get_object_or_404(Notificacao, id=notificacao_id, usuario=request.user)
    notificacao.lida = True
    notificacao.save()

    # Sempre retorna para a lista de notificações
    return redirect('notificacoes')


@login_required
def marcar_todas_lidas_view(request):
    request.user.notificacoes.filter(lida=False).update(lida=True)
    return redirect('notificacoes')
