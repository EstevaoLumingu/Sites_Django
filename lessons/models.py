from django.db import models
from django.conf import settings
from classroom.models import Classroom
from django.utils.text import slugify
import uuid

class LiveLesson(models.Model):
    classroom = models.ForeignKey(Classroom, on_delete=models.CASCADE, related_name='aulas')
    titulo = models.CharField(max_length=100)
    descricao = models.TextField(blank=True)
    horario = models.DateTimeField()
    criado_por = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        limit_choices_to={'tipo_acesso': 'professor'},
        verbose_name="Professor"
    )
    slug_sala = models.SlugField(unique=True, blank=True)

    criado_em = models.DateTimeField(auto_now_add=True)

    def save(self, *args, **kwargs):
        if not self.slug_sala:
            unique_id = uuid.uuid4().hex[:10]
            self.slug_sala = slugify(f"{self.classroom.id}-{self.titulo}-{unique_id}")
        super().save(*args, **kwargs)

    def get_jitsi_url(self):
        return f"https://meet.jit.si/{self.slug_sala}"

    def __str__(self):
        return self.titulo

from django.conf import settings

class ParticipacaoAluno(models.Model):
    AVALIACOES = [
        ('pessimo', 'Péssimo'),
        ('ruim', 'Ruim'),
        ('bom', 'Bom'),
        ('muito_bom', 'Muito Bom'),
        ('excelente', 'Excelente'),
    ]

    aula = models.ForeignKey('LiveLesson', on_delete=models.CASCADE, related_name='participacoes')
    aluno = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    presente = models.BooleanField(default=False)
    avaliacao = models.CharField(max_length=20, choices=AVALIACOES, blank=True, null=True)

    criado_em = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('aula', 'aluno')

    def __str__(self):
        return f"{self.aluno.username} em {self.aula.titulo}"



class MaterialDidatico(models.Model):
    CATEGORIAS = [
        ('material', 'Material de Aula'),
        ('tarefa', 'Tarefa'),
    ]

    titulo = models.CharField(max_length=150)
    arquivo = models.FileField(upload_to='materiais/')
    categoria = models.CharField(max_length=20, choices=CATEGORIAS)
    aula = models.ForeignKey('LiveLesson', on_delete=models.CASCADE)
    sala = models.ForeignKey('classroom.Classroom', on_delete=models.CASCADE)
    criado_por = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    criado_em = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.titulo} - {self.criado_por}"
