from django import forms
from .models import QuizPergunta, QuizResposta
from django import forms
from .models import QuizPergunta, QuizResposta
from courses.models import Course


class QuizRespostaForm(forms.Form):
    def __init__(self, *args, **kwargs):
        pergunta = kwargs.pop('pergunta')
        super().__init__(*args, **kwargs)
        respostas = pergunta.respostas.all()
        self.fields['resposta'] = forms.ChoiceField(
            label=pergunta.pergunta,
            choices=[(r.id, r.texto) for r in respostas],
            widget=forms.RadioSelect
        )


class PerguntaNivelamentoForm(forms.ModelForm):
    class Meta:
        model = QuizPergunta
        fields = ['curso', 'nivel', 'pergunta']
        widgets = {
            'pergunta': forms.Textarea(attrs={'rows': 3, 'placeholder': 'Digite a pergunta aqui'}),
            'nivel': forms.Select(attrs={'class': 'form-select'}),
            'curso': forms.Select(attrs={'class': 'form-select'}),
        }

class RespostaForm(forms.ModelForm):
    class Meta:
        model = QuizResposta
        fields = ['texto', 'correta']
