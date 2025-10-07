from django import forms
from .models import LiveLesson, MaterialDidatico
from classroom.models import Classroom


class LiveLessonForm(forms.ModelForm):
    class Meta:
        model = LiveLesson
        fields = ['classroom', 'titulo', 'descricao', 'horario']
        widgets = {
            'horario': forms.DateTimeInput(
                attrs={
                    'type': 'datetime-local',
                    'class': 'form-control',
                    'placeholder': 'Seleciona a data e hora'
                }
            )
        }

    def __init__(self, *args, **kwargs):
        professor = kwargs.pop('professor')
        sala_inicial = kwargs.pop('sala_inicial', None)
        super().__init__(*args, **kwargs)

        # Limita salas ao professor logado
        self.fields['classroom'].queryset = Classroom.objects.filter(professor=professor)
        self.fields['classroom'].widget.attrs.update({'class': 'form-select'})

        if sala_inicial:
            self.fields['classroom'].initial = sala_inicial

        # Adiciona classes Bootstrap aos outros campos
        self.fields['titulo'].widget.attrs.update({'class': 'form-control'})
        self.fields['descricao'].widget.attrs.update({'class': 'form-control', 'rows': 3})



from django import forms
from .models import MaterialDidatico
from classroom.models import Classroom


class MaterialDidaticoForm(forms.ModelForm):
    class Meta:
        model = MaterialDidatico
        fields = ['titulo', 'categoria', 'arquivo', 'sala', 'aula']

    def __init__(self, *args, **kwargs):
        user = kwargs.pop('user', None)
        super().__init__(*args, **kwargs)

        self.fields['aula'].queryset = LiveLesson.objects.none()  # inicial vazio

        if user:
            if user.categoria == 'estudante':
                self.fields['sala'].queryset = user.salas_matriculadas.all()
            elif user.categoria == 'professor':
                self.fields['sala'].queryset = Classroom.objects.filter(professor=user)

            # Pré-carregar aulas se sala estiver no form
            if 'sala' in self.data:
                try:
                    sala_id = int(self.data.get('sala'))
                    self.fields['aula'].queryset = LiveLesson.objects.filter(classroom_id=sala_id)
                except (ValueError, TypeError):
                    pass
            elif self.instance.pk:
                self.fields['aula'].queryset = self.instance.sala.aulas.all()
