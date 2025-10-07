from .models import Notificacao

def notificacoes_nao_lidas(request):
    if request.user.is_authenticated:
        total = Notificacao.objects.filter(usuario=request.user, lida=False).count()
    else:
        total = 0
    return {'total_notificacoes': total}
