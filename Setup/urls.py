"""
URL configuration for Setup project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static



from Setup.settings import DEBUG

urlpatterns = [
    path('admin/', admin.site.urls),
    path('painel-admin/', include('adminpanel.urls')),
 
    path('', include('main.urls')),
    path('conta/', include('users.urls')),
    path('cursos/', include('courses.urls')),
    path('salas/', include('classroom.urls')),
    path('aulas/', include('lessons.urls')),
    path('nivelamento/', include('nivelamento.urls')),
    path('comunicacao/', include('comunicacao.urls')),
    path('notificacoes/', include('notificacoes.urls')),
     path('financeiro/', include('financeiro.urls')), 
]


if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)