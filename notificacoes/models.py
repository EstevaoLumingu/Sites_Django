from django.db import models
from django.conf import settings

class Notificacao(models.Model):
    usuario = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='notificacoes')
    mensagem = models.TextField()
    lida = models.BooleanField(default=False)
    data = models.DateTimeField(auto_now_add=True)
    url_destino = models.URLField(blank=True, null=True)

    def __str__(self):
        return f"{self.usuario.username} - {'Lida' if self.lida else 'Nova'}"
