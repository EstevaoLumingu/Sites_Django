from django.urls import path
from .views import (
    painel_financeiro_view,
    criar_plano_view,
    editar_plano_view,
    deletar_plano_view,
)

urlpatterns = [
    path('painel/', painel_financeiro_view, name='painel_financeiro'),
    path('planos/novo/', criar_plano_view, name='criar_plano'),
    path('planos/<int:plano_id>/editar/', editar_plano_view, name='editar_plano'),
    path('planos/<int:plano_id>/deletar/', deletar_plano_view, name='deletar_plano'),
]

