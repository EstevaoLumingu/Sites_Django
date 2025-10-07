from django.db import models
from django.conf import settings
from courses.models import Course

class Classroom(models.Model):
    NIVEIS = [
        ('iniciante', 'Iniciante'),
        ('pre_intermedio', 'Pré-Intermédio'),
        ('intermedio', 'Intermédio'),
        ('avancado', 'Avançado'),
    ]

    curso = models.ForeignKey(Course, on_delete=models.CASCADE, verbose_name="Curso")
    nivel = models.CharField(max_length=20, choices=NIVEIS, verbose_name="Nível")
    titulo = models.CharField(max_length=100)
    descricao = models.TextField()
    data_inicio = models.DateField()
    data_fim = models.DateField()

    professor = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        limit_choices_to={'categoria': 'professor'}, 
        verbose_name="Professor Responsável"
    )

    alunos = models.ManyToManyField(
        settings.AUTH_USER_MODEL,
        related_name="salas_matriculadas",
        blank=True,
        verbose_name="Alunos na Sala"
    )

    criado_em = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.titulo} ({self.nivel})"
