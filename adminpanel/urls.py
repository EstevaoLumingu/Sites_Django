from django.urls import path
from .views import criar_usuario_admin_view, excluir_usuario_view, marcar_mensagem_lida_view, painel_admin_home

from django.urls import path
from .views import (
    painel_admin_home,
    listar_cursos_view,
    criar_curso_admin_view,
    editar_curso_admin_view,
    excluir_curso_admin_view,
    listar_usuarios_view, editar_usuario_admin_view, alternar_ativo_view,
)
from .views import (
    listar_salas_admin_view,
    criar_sala_admin_view,
    editar_sala_admin_view,
    excluir_sala_admin_view,
)
from .views import estatisticas_admin_view
from .views import (
    painel_admin_home,
    gerir_testes_nivelamento_view,
    listar_mensagens_contato_view,
    avaliar_professores_admin_view,
)

urlpatterns = [
    path('', painel_admin_home, name='painel_admin_home'),
    
    # Cursos
    path('cursos/', listar_cursos_view, name='listar_cursos_admin'),
    path('cursos/criar/', criar_curso_admin_view, name='criar_curso_admin'),
    path('cursos/<int:curso_id>/editar/', editar_curso_admin_view, name='editar_curso_admin'),
    path('cursos/<int:curso_id>/excluir/', excluir_curso_admin_view, name='excluir_curso_admin'),
    path('usuarios/<int:user_id>/excluir/', excluir_usuario_view, name='excluir_usuario_admin'),
]

urlpatterns += [
    # Usuários
    path('usuarios/', listar_usuarios_view, name='listar_usuarios_admin'),
    path('usuarios/<int:user_id>/editar/', editar_usuario_admin_view, name='editar_usuario_admin'),
    path('usuarios/<int:user_id>/ativo/', alternar_ativo_view, name='alternar_ativo_usuario'),
    path('usuarios/criar/', criar_usuario_admin_view, name='criar_usuario_admin'),

]

urlpatterns += [
    path('salas/', listar_salas_admin_view, name='listar_salas_admin'),
    path('salas/criar/', criar_sala_admin_view, name='criar_sala_admin'),
    path('salas/<int:sala_id>/editar/', editar_sala_admin_view, name='editar_sala_admin'),
    path('salas/<int:sala_id>/excluir/', excluir_sala_admin_view, name='excluir_sala_admin'),
]


urlpatterns += [
    path('estatisticas/', estatisticas_admin_view, name='estatisticas_admin'),
]


urlpatterns += [
    path('nivelamento/testes/', gerir_testes_nivelamento_view, name='gerir_testes_nivelamento'),
    path('contato/', listar_mensagens_contato_view, name='listar_mensagens_contato'),
    path('avaliacoes/', avaliar_professores_admin_view, name='avaliar_professores_admin'),
    path("contato/<int:mensagem_id>/lida/", marcar_mensagem_lida_view, name="marcar_mensagem_lida"),

]
