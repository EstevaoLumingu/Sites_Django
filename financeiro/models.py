from django.db import models


class ConfiguracaoFinanceira(models.Model):
    nome_banco = models.CharField(max_length=100)
    titular_conta = models.CharField(max_length=100)
    numero_conta = models.CharField(max_length=30)
    iban = models.CharField(max_length=40)
    swift = models.CharField(max_length=20, blank=True, null=True)
    instrucao_extra = models.TextField(blank=True, null=True)

    ultima_atualizacao = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.nome_banco} ({self.titular_conta})"
