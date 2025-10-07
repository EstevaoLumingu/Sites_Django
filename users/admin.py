from django.contrib import admin

# Register your models here.
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import CustomUser

class CustomUserAdmin(UserAdmin):
    model = CustomUser
    fieldsets = UserAdmin.fieldsets + (
        ('Informações Adicionais', {
            'fields': (
                'categoria', 'grau_academico', 'especialidade',
                'foto_perfil', 'phone_number', 'address', 'status', 'tipo_acesso', 'is_admin',
            ),
        }),
    )

admin.site.register(CustomUser, CustomUserAdmin)
