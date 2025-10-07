from .models import Notificacao

def notificar(usuario, mensagem, url_destino=None):
    Notificacao.objects.create(
        usuario=usuario,
        mensagem=mensagem,
        url_destino=url_destino
    )
