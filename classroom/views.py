from django.http import HttpResponseForbidden
from django.shortcuts import get_object_or_404, render,redirect
from notificacoes.utils import notificar
from users.models import CustomUser
from .models import Classroom
from django.contrib.auth.decorators import login_required
from .forms import CriarSalaForm
from courses.models import Enrollment
from django.contrib import messages
from datetime import datetime


@login_required
def salas_disponiveis_view(request):
    salas = Classroom.objects.all()
    return render(request, 'classroom/lista_salas.html', {'salas': salas})


