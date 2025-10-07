from django.contrib import admin
from .models import Notificacao

@admin.register(Notificacao)
class NotificacaoAdmin(admin.ModelAdmin):
    list_display = ['usuario', 'mensagem', 'lida', 'data']
    list_filter = ['lida', 'data']
    search_fields = ['usuario__username', 'mensagem']
