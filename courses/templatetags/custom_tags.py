from django import template

register = template.Library()

@register.simple_tag
def in_matriculas(curso_id, nivel, matriculas_ids):
    return (curso_id, nivel) in matriculas_ids
