from django.db import models
from django.conf import settings


class Course(models.Model):
    nome = models.CharField(max_length=100, unique=True, verbose_name="Nome do Curso")
    descricao = models.TextField(verbose_name="Descrição")
    imagem = models.ImageField(upload_to="cursos/imagens/", null=True, blank=True)

    professor = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        limit_choices_to={'categoria': 'professor'},
        verbose_name="Professor Responsável"
    )

    alunos = models.ManyToManyField(
        settings.AUTH_USER_MODEL,
        related_name='cursos_matriculados',
        blank=True,
        verbose_name="Alunos Matriculados",
        limit_choices_to={'categoria': 'estudante'}
    )

    criado_em = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.nome


class Enrollment(models.Model):
    aluno = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    curso = models.ForeignKey('Course', on_delete=models.CASCADE)
    data_matricula = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('aluno', 'curso')

    def __str__(self):
        return f"{self.aluno.get_full_name()} → {self.curso.nome}"

class DadosPagamento(models.Model):
    banco = models.CharField(max_length=100)
    titular = models.CharField(max_length=100)
    conta = models.CharField(max_length=50)
    iban = models.CharField(max_length=50)
    instrucoes_extra = models.TextField(blank=True, null=True)

    def __str__(self):
        return "Configuração de Pagamento"


FREQUENCIAS = [
    ("1x", "1 vez por semana"),
    ("2x", "2 vezes por semana"),
    ("3x", "3 vezes por semana"),
]

DURACOES = [
    ("30min", "30 minutos"),
    ("1h", "1 hora"),
]

class PlanoPrecoCurso(models.Model):
    curso = models.ForeignKey("courses.Course", on_delete=models.CASCADE)
    duracao = models.CharField(max_length=10, choices=DURACOES)
    frequencia = models.CharField(max_length=10, choices=FREQUENCIAS)
    preco = models.DecimalField(max_digits=10, decimal_places=2)

    def __str__(self):
        return f"{self.curso.nome} | {self.get_duracao_display()} | {self.get_frequencia_display()} - {self.preco} Kz"
