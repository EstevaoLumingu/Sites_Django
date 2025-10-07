from . import views
from django.urls import path
from .views import register_view, login_view, logout_view
from .views import dashboard_professor_view, dashboard_estudante_view
from .views import painel_aluno_view
from .views import perfil_view

urlpatterns = [
    path('entrar/', login_view, name='login'),
    path('sair/', logout_view, name='logout'),
    path('registar/', register_view, name='register'),  
    path('notificacoes/', views.lista_notificacoes_view, name='notificacoes'),
    path('notificacoes/<int:notificacao_id>/lida/', views.marcar_lida_view, name='marcar_lida'),
    path('notificacoes/todas-lidas/', views.marcar_todas_lidas_view, name='marcar_todas_lidas'),
]

urlpatterns += [
    path('painel/professor/', dashboard_professor_view, name='dashboard_professor'),
    path('painel/estudante/', dashboard_estudante_view, name='dashboard_estudante'),
]

urlpatterns += [
    path('painel/aluno/', painel_aluno_view, name='painel_aluno'),
]

urlpatterns += [
    path('meu-perfil/', perfil_view, name='meu_perfil'),
]
from .views import alterar_senha_view

urlpatterns += [
    path('meu-perfil/alterar-senha/', alterar_senha_view, name='alterar_senha'),
]
