from django.contrib import admin
from .models import Classroom

@admin.register(Classroom)
class ClassroomAdmin(admin.ModelAdmin):
    list_display = ('titulo', 'curso', 'nivel', 'professor', 'data_inicio')
    list_filter = ('curso', 'nivel')
    search_fields = ('titulo', 'professor__username')
    filter_horizontal = ('alunos',)
    
