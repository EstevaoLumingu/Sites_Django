from django import forms
from .models import Course

class CriarCursoForm(forms.ModelForm):
    class Meta:
        model = Course
        fields = ['nome', 'descricao', 'imagem']
        widgets = {
            'descricao': forms.Textarea(attrs={'rows': 4}),
        }
