from django.urls import path
from .views import entrar_na_aula_view
from .views import (
    entrar_na_aula_view,
    painel_aulas_professor_view,
    criar_aula_view,
    painel_sala_view
)
from .views import painel_salas_professor
from .views import aulas_por_sala_view, editar_aula_view, remover_aula_view
from .views import avaliar_participacao_view
from .views import marcar_presenca_view
from . import views

urlpatterns = [
    path('<slug:slug_sala>/', entrar_na_aula_view, name='entrar_aula'),
    path('painel/professor/aulas/', painel_aulas_professor_view, name='painel_aulas_professor'),
    path('painel/professor/aulas/criar/', criar_aula_view, name='criar_aula'), 
    path('aula/<int:aula_id>/editar/', editar_aula_view, name='editar_aula'),
    path('aula/<int:aula_id>/remover/', remover_aula_view, name='remover_aula'),
    path('aula/<int:aula_id>/avaliar/', avaliar_participacao_view, name='avaliar_participacao'),
    path('sala/<int:sala_id>/', painel_sala_view, name='painel_sala'),
    path('aula/<int:aula_id>/presenca/', marcar_presenca_view, name='marcar_presenca'),
    path('painel/professor/salas/', painel_salas_professor, name='painel_salas_professor'),
    path('painel/professor/salas/<int:sala_id>/aulas/', aulas_por_sala_view, name='aulas_por_sala'),
    path("materiais/<int:sala_id>/", views.painel_materiais_view, name="painel_materiais"),
    path('materiais/meus/', views.meus_materiais_view, name='meus_materiais'),
    path('materiais/recebidos/', views.materiais_recebidos_view, name='materiais_recebidos'),
    path('materiais/enviar/', views.enviar_material_view, name='enviar_material'),
    path('ajax/aulas_por_sala/<int:sala_id>/', views.ajax_aulas_por_sala, name='ajax_aulas_por_sala'),
    path('materiais/<int:material_id>/remover/', views.deletar_material_view, name='remover_material'),
    path('materiais/<int:material_id>/baixar/', views.baixar_material_view, name='baixar_material'),
    ]


