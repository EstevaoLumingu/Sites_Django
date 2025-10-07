from django.contrib import admin

# Register your models here.
from django.contrib import admin
from .models import LiveLesson

@admin.register(LiveLesson)
class LiveLessonAdmin(admin.ModelAdmin):
    list_display = ('titulo', 'classroom', 'horario', 'criado_por')
    search_fields = ('titulo', 'classroom__titulo')
    list_filter = ('classroom',)


