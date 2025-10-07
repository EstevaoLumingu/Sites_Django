from django.urls import path
from .views import marcar_notificacoes_lidas

urlpatterns = [
    path('marcar-lidas/', marcar_notificacoes_lidas, name='marcar_notificacoes_lidas'),
]
