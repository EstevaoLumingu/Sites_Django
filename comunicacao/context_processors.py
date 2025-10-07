from comunicacao.models import Mensagem

def mensagens_nao_lidas_processor(request):
    if request.user.is_authenticated:
        total = Mensagem.objects.filter(destinatario=request.user, lida=False).count()
        return {'mensagens_nao_lidas_count': total}
    return {}
