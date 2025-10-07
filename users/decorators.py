from django.core.exceptions import PermissionDenied

def professor_required(view_func):
    def _wrapped_view(request, *args, **kwargs):
        if request.user.is_authenticated and request.user.categoria == 'professor':
            return view_func(request, *args, **kwargs)
        raise PermissionDenied
    return _wrapped_view
