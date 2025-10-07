from django.shortcuts import redirect
from functools import wraps

def admin_required(view_func):
    @wraps(view_func)
    def _wrapped_view(request, *args, **kwargs):
        if request.user.is_authenticated and (
            request.user.is_superuser or request.user.tipo_acesso == 'admin' or request.user.is_admin
        ):
            return view_func(request, *args, **kwargs)
        return redirect('login')
    return _wrapped_view
