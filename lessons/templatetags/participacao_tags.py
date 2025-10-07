from django import template
from lessons.models import ParticipacaoAluno

register = template.Library()

@register.filter
def get_participacao(participacoes, aluno):
    return participacoes.filter(aluno=aluno).first()

from django import template

register = template.Library()

@register.filter
def dictkey(d, key):
    return d.get(key)
