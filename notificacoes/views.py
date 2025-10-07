from django.shortcuts import render

# Create your views here.
from django.contrib.auth.decorators import login_required
from django.shortcuts import redirect
from .models import Notificacao

@login_required
def marcar_notificacoes_lidas(request):
    request.user.notificacoes.filter(lida=False).update(lida=True)
    return redirect(request.META.get('HTTP_REFERER', 'home'))
