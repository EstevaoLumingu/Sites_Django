from django.contrib import admin
from .models import Nivelamento
from django.contrib import admin
from .models import QuizPergunta, QuizResposta, ResultadoTeste


@admin.register(Nivelamento)
class NivelamentoAdmin(admin.ModelAdmin):
    list_display = ('curso', 'pergunta', 'resposta_correta')


class QuizRespostaInline(admin.TabularInline):
    model = QuizResposta
    extra = 2

@admin.register(QuizPergunta)
class QuizPerguntaAdmin(admin.ModelAdmin):
    inlines = [QuizRespostaInline]

admin.site.register(ResultadoTeste)
