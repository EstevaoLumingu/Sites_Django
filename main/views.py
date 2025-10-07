from django.contrib.auth.decorators import login_required
from django.shortcuts import render
from django.conf import settings



@login_required
def home(request):
    return render(request, 'main/home.html')
