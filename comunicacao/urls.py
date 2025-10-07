from django.urls import path
from . import views

urlpatterns = [
    # Contato e avaliações
    path('contato/', views.contato_view, name='contato'),
    path('avaliar/<int:professor_id>/', views.avaliar_professor_view, name='avaliar_professor'),

    # Pesquisar e ver colegas
    path('colegas/', views.painel_colegas_view, name='painel_colegas'),
    path('perfil/<int:user_id>/', views.ver_perfil_view, name='ver_perfil'),

    # Sistema de mensagens
    path('mensagens/', views.painel_mensagens_view, name='mensagens_lista'),  # Lista de conversas
    path('mensagens/<int:user_id>/', views.painel_mensagens_view, name='mensagens_com_usuario'),  # Abre conversa com user

    # API / ações específicas
    path('conversa/<int:user_id>/', views.mensagens_view, name='mensagem_view'),  # usada por AJAX (enviar/receber mensagens)
    path('enviar/', views.enviar_mensagem_view, name='enviar_mensagem'),
]
