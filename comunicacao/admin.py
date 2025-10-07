from django.contrib import admin
from .models import MensagemContato, AvaliacaoProfessor

@admin.register(MensagemContato)
class MensagemContatoAdmin(admin.ModelAdmin):
    list_display = ['nome', 'email', 'assunto', 'lida', 'data_envio']
    list_filter = ['lida', 'data_envio']
    search_fields = ['nome', 'email', 'assunto']

@admin.register(AvaliacaoProfessor)
class AvaliacaoProfessorAdmin(admin.ModelAdmin):
    list_display = ['professor', 'aluno', 'nota', 'data']
    search_fields = ['professor__username', 'aluno__username']

