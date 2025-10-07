from django.contrib import admin

from .models import Course, DadosPagamento

@admin.register(Course)
class CourseAdmin(admin.ModelAdmin):
    list_display = ('nome', 'professor', 'criado_em')
    search_fields = ('nome',)

admin.site.register(DadosPagamento)


from .models import PlanoPrecoCurso #ConfiguracaoFinanceira

admin.site.register(PlanoPrecoCurso)
#admin.site.register(ConfiguracaoFinanceira)
