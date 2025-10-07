from django.urls import path
from .views import salas_disponiveis_view

urlpatterns = [
    path('', salas_disponiveis_view, name='lista_salas'),

]

