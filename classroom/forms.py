from django import forms
from .models import Classroom


class CriarSalaForm(forms.ModelForm):
    class Meta:
        model = Classroom
        fields = ['curso', 'titulo', 'nivel', 'professor', 'data_inicio', 'data_fim']

        widgets = {
            'data_inicio': forms.DateInput(attrs={
                'type': 'date',
                'class': 'form-control'
            }),
            'data_fim': forms.DateInput(attrs={
                'type': 'date',
                'class': 'form-control'
            }),
        }

        labels = {
            'curso': 'Curso',
            'titulo': 'Nome da Sala',
            'nivel': 'Nível',
            'professor': 'Professor Responsável',
            'data_inicio': 'Data de Início',
            'data_fim': 'Data de Fim',
        }
