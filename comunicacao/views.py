from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from .models import MensagemContato, AvaliacaoProfessor
from users.models import CustomUser
from django.http import JsonResponse
from .models import Mensagem
from django.db.models import Q

def contato_view(request):
    if request.method == 'POST':
        MensagemContato.objects.create(
            nome=request.POST.get('nome'),
            email=request.POST.get('email'),
            assunto=request.POST.get('assunto'),
            mensagem=request.POST.get('mensagem')
        )
        messages.success(request, "Mensagem enviada com sucesso! Obrigado pelo seu contacto.")
        return redirect('home')
    return render(request, 'comunicacao/contato.html')

@login_required
def avaliar_professor_view(request, professor_id):
    professor = get_object_or_404(CustomUser, id=professor_id, categoria='professor')
    if request.method == 'POST':
        nota = int(request.POST.get('nota'))
        comentario = request.POST.get('comentario')
        AvaliacaoProfessor.objects.create(
            professor=professor,
            aluno=request.user,
            nota=nota,
            comentario=comentario
        )
        messages.success(request, "Avaliação enviada com sucesso!")
        return redirect('painel_aluno')
    return render(request, 'comunicacao/avaliar_professor.html', {'professor': professor})

@login_required
def painel_colegas_view(request):
    termo = request.GET.get('q', '')
    user_id = request.GET.get('user_id')

    colegas = CustomUser.objects.exclude(id=request.user.id)

    if termo:
        colegas = colegas.filter(
            Q(username__icontains=termo) |
            Q(first_name__icontains=termo) |
            Q(last_name__icontains=termo)
        )

    perfil = None
    if user_id:
        perfil = get_object_or_404(CustomUser, id=user_id)

    return render(request, 'comunicacao/painel_colegas.html', {
        'colegas': colegas,
        'perfil': perfil
    })

@login_required
def ver_perfil_view(request, user_id):
    colega = get_object_or_404(CustomUser, id=user_id)
    return render(request, "comunicacao/ver_perfil.html", {"colega": colega})

@login_required
def mensagens_view(request, user_id):
    colega = get_object_or_404(CustomUser, id=user_id)
    mensagens = Mensagem.objects.filter(
        Q(remetente=request.user, destinatario=colega) |
        Q(remetente=colega, destinatario=request.user)
    ).order_by('criada_em')

    # Marca como lidas
    mensagens.filter(destinatario=request.user, lida=False).update(lida=True)

    return render(request, "comunicacao/chat.html", {"colega": colega, "mensagens": mensagens})

@login_required
def enviar_mensagem_view(request):
    if request.method == "POST":
        tipo = request.POST.get("tipo")
        conteudo = request.POST.get("conteudo", "")
        destinatario_id = request.POST.get("destinatario")
        arquivo = request.FILES.get("arquivo")

        destinatario = get_object_or_404(CustomUser, id=destinatario_id)

        mensagem = Mensagem.objects.create(
            remetente=request.user,
            destinatario=destinatario,
            tipo=tipo,
            conteudo=conteudo,
            arquivo=arquivo
        )

        return JsonResponse({
            "status": "ok",
            "mensagem_id": mensagem.id,
            "tipo": mensagem.tipo,
            "conteudo": mensagem.conteudo,
            "arquivo_url": mensagem.arquivo.url if mensagem.arquivo else "",
            "hora": mensagem.criada_em.strftime("%H:%M")
        })

    return JsonResponse({"status": "erro"}, status=400)

@login_required
def painel_mensagens_view(request, user_id=None):
    from django.db.models import Q
    from comunicacao.models import Mensagem
    from users.models import CustomUser

    usuario = request.user

    # 🔍 Pesquisar colegas
    q = request.GET.get("q")
    users = CustomUser.objects.exclude(id=usuario.id)
    if q:
        users = users.filter(Q(username__icontains=q) | Q(first_name__icontains=q) | Q(last_name__icontains=q))

    # 🔁 Buscar usuários com quem já conversei
    mensagens = Mensagem.objects.filter(Q(remetente=usuario) | Q(destinatario=usuario)).select_related('remetente', 'destinatario')
    conversas_ids = set()
    for m in mensagens:
        if m.remetente != usuario:
            conversas_ids.add(m.remetente.id)
        if m.destinatario != usuario:
            conversas_ids.add(m.destinatario.id)
    conversas = CustomUser.objects.filter(id__in=conversas_ids)

    # 🔘 Determina o usuário ativo da conversa
    ativo = None
    mensagens_da_conversa = []
    if user_id:
        ativo = get_object_or_404(CustomUser, id=user_id)
        mensagens_da_conversa = Mensagem.objects.filter(
            Q(remetente=usuario, destinatario=ativo) | Q(remetente=ativo, destinatario=usuario)
        ).order_by('criada_em')

    return render(request, 'comunicacao/painel_mensagens.html', {
        'conversas': conversas,
        'ativo': ativo,
        'mensagens': mensagens_da_conversa,
    })
