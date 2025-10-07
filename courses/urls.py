from django.urls import path
from .views import lista_cursos_view
from .views import cursos_disponiveis_view, matricular_view

urlpatterns = [
    path('', lista_cursos_view, name='lista_cursos'),
]

urlpatterns += [
    
    path('disponiveis/', cursos_disponiveis_view, name='cursos_disponiveis'),
    path('matricular/<int:curso_id>/', matricular_view, name='matricular'),
]
from .views import criar_curso_view

urlpatterns += [
    path('criar/', criar_curso_view, name='criar_curso'),
]
