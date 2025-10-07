from django.db import models
from django.conf import settings

class MensagemContato(models.Model):
    nome = models.CharField(max_length=100)
    email = models.EmailField()
    assunto = models.CharField(max_length=200)
    mensagem = models.TextField()
    lida = models.BooleanField(default=False)
    data_envio = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.assunto} ({self.nome})"

class AvaliacaoProfessor(models.Model):
    professor = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='avaliacoes_recebidas'
    )
    aluno = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='avaliacoes_feitas'
    )
    comentario = models.TextField()
    nota = models.IntegerField(choices=[(i, str(i)) for i in range(1,10)])
    data = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Avaliação de {self.aluno} → {self.professor} ({self.nota}/5)"



from django.db import models
from django.conf import settings

class Mensagem(models.Model):
    TEXTO = 'texto'
    IMAGEM = 'imagem'
    AUDIO = 'audio'
    VIDEO = 'video'

    TIPOS = [
        (TEXTO, 'Texto'),
        (IMAGEM, 'Imagem'),
        (AUDIO, 'Áudio'),
        (VIDEO, 'Vídeo'),
    ]

    remetente = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='enviadas')
    destinatario = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='recebidas')

    tipo = models.CharField(max_length=10, choices=TIPOS, default=TEXTO)
    conteudo = models.TextField(blank=True)
    arquivo = models.FileField(upload_to='mensagens/', blank=True, null=True)

    lida = models.BooleanField(default=False)
    criada_em = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['criada_em']

    def __str__(self):
        return f"{self.remetente} → {self.destinatario} [{self.tipo}]"

