from django.urls import path
from .views import *

urlpatterns = [
    path('curso/<int:curso_id>/teste/', fazer_teste_view, name='fazer_teste'),
    path('resultado/<int:resultado_id>/', resultado_teste_view, name='resultado_teste'),
    path('resultado/<int:resultado_id>/detalhes/', ver_resultado_detalhado_view, name='ver_resultado_detalhado'),


    path('pedidos/', listar_pedidos_view, name='listar_pedidos'), 
    path('pedidos/<int:pedido_id>/avaliar/', avaliar_pedido_view, name='avaliar_pedido'),

    path('curso/<int:curso_id>/resultado/<int:resultado_id>/pagamento/', pagina_pagamento_view, name='pagina_pagamento'),

    # Admin perguntas
    path('admin/perguntas/', listar_perguntas_view, name='listar_perguntas_nivelamento'),
    path('admin/perguntas/criar/', criar_pergunta_nivelamento_view, name='criar_pergunta_nivelamento'),
    path('admin/testes/<int:pergunta_id>/editar/', editar_pergunta_admin_view, name='editar_pergunta_admin'),
    path('admin/testes/<int:pergunta_id>/excluir/', excluir_pergunta_admin_view, name='excluir_pergunta_admin'),

    path('gerar-pergunta-ia/', gerar_pergunta_ia_view, name='gerar_pergunta_ia'),
]
