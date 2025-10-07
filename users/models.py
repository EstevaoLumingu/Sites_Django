from django.contrib.auth.models import AbstractUser
from django.db import models
from django.core.exceptions import ValidationError

class CustomUser(AbstractUser):
    CATEGORIAS = [
        ('estudante', 'Estudante'),
        ('professor', 'Professor'),
    ]

    GRAUS_ACADEMICOS = [
        ('ensino_primario', 'Ensino Primário'),
        ('1_ciclo', '1.º Ciclo'),
        ('ensino_medio', 'Ensino Médio'),
        ('universitario', 'Universitário'),
        ('licenciado', 'Licenciado'),
        ('mestre', 'Mestre'),
        ('phd', 'Pós-Doutoramento'),
    ]

    STATUS_CHOICES = [
        ('disponivel', 'Disponível'),
        ('indisponivel', 'Indisponível'),
    ]

    TIPOS_ACESSO = [
        ('padrao', 'Usuário Padrão'),
        ('admin', 'Administrador Central'),
        ('professor', 'Professor'),
    ]

    email = models.EmailField(unique=True)
    foto_perfil = models.ImageField(upload_to='fotos_perfil/', null=True, blank=True, verbose_name="Foto de perfil")
    phone_number = models.CharField(max_length=15, blank=True, null=True)
    address = models.TextField(blank=True, null=True)
    categoria = models.CharField(max_length=20, choices=CATEGORIAS, verbose_name="Categoria")
    grau_academico = models.CharField(max_length=20, choices=GRAUS_ACADEMICOS, blank=True, verbose_name="Grau académico")
    especialidade = models.CharField(max_length=255, blank=True, null=True, verbose_name="Especialidade")
    status = models.CharField(max_length=15, choices=STATUS_CHOICES, default='disponivel', verbose_name="Estado")
    tipo_acesso = models.CharField(max_length=30, choices=TIPOS_ACESSO, default='padrao', verbose_name="Tipo de acesso")
    is_admin = models.BooleanField(default=False, verbose_name="É administrador")

   
    def __str__(self):
        return self.get_full_name() or self.username
