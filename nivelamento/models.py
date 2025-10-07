from django.db import models
from courses.models import Course
from django.conf import settings
from courses.models import PlanoPrecoCurso


NIVEIS = [
    ('iniciante', 'Iniciante'),
    ('pre_intermedio', 'Pré-Intermédio'),
    ('intermedio', 'Intermédio'),
    ('avancado', 'Avançado'),      
]

class QuizPergunta(models.Model):
    curso = models.ForeignKey(Course, on_delete=models.CASCADE)
    nivel = models.CharField(max_length=20, choices=NIVEIS)
    pergunta = models.TextField()

    def __str__(self):
        return self.pergunta

class QuizResposta(models.Model):
    pergunta = models.ForeignKey(QuizPergunta, on_delete=models.CASCADE, related_name='respostas')
    texto = models.CharField(max_length=255)
    correta = models.BooleanField(default=False)

    def __str__(self):
        return f"{self.texto} ({'✔' if self.correta else '✘'})"

class ResultadoTeste(models.Model):
    aluno = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    curso = models.ForeignKey(Course, on_delete=models.CASCADE)
    pontuacao = models.IntegerField()
    nivel_atribuido = models.CharField(max_length=20, choices=NIVEIS)
    data = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.aluno.username} - {self.nivel_atribuido}"
    
class RespostaAluno(models.Model):
    resultado = models.ForeignKey(ResultadoTeste, on_delete=models.CASCADE, related_name="respostas_aluno")
    pergunta = models.ForeignKey(QuizPergunta, on_delete=models.CASCADE)
    resposta_escolhida = models.ForeignKey(QuizResposta, on_delete=models.SET_NULL, null=True, blank=True)

    def __str__(self):
        return f"{self.resultado.aluno.username} → {self.pergunta.pergunta[:30]}"



class Nivelamento(models.Model):
    curso = models.ForeignKey(Course, on_delete=models.CASCADE)
    pergunta = models.CharField(max_length=255)
    opcoes = models.JSONField()  # {'a': 'resposta A', 'b': 'resposta B'}
    resposta_correta = models.CharField(max_length=1)  # Ex: 'a'

    def __str__(self):
        return f"{self.curso.nome} - {self.pergunta[:30]}"



class PedidoMatricula(models.Model):
    aluno = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    curso = models.ForeignKey(Course, on_delete=models.CASCADE)
    resultado_teste = models.ForeignKey(ResultadoTeste, on_delete=models.CASCADE)

    plano = models.ForeignKey(PlanoPrecoCurso, on_delete=models.SET_NULL, null=True, blank=True)

    comprovativo = models.FileField(upload_to="pagamentos/comprovativos/", null=True, blank=True)
    pagamento_enviado = models.BooleanField(default=False)
    avaliado_pagamento_em = models.DateTimeField(null=True, blank=True)

    aprovado = models.BooleanField(default=False)
    avaliado = models.BooleanField(default=False)
    data_solicitacao = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.aluno} - {self.curso} - {self.plano or 'Sem Plano'}"
