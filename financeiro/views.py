from django.contrib.auth.decorators import login_required, user_passes_test
from django.shortcuts import render, redirect
from nivelamento.models import PedidoMatricula
from .models import ConfiguracaoFinanceira
from courses.models import Course
from django.shortcuts import render, get_object_or_404
from django.contrib import messages
from django.contrib.auth.decorators import login_required, user_passes_test
from courses.models import PlanoPrecoCurso



def is_admin_or_superuser(user):
    return user.is_authenticated and (user.is_superuser or user.is_admin)

from django.utils import timezone
from datetime import datetime

@login_required
@user_passes_test(is_admin_or_superuser)
def painel_financeiro_view(request):
    secao = request.GET.get("secao", "planos")
    cursos = Course.objects.all()
    planos = PlanoPrecoCurso.objects.select_related("curso").all()
    dados_bancarios = ConfiguracaoFinanceira.objects.first()

    # 📌 Processar criação/edição de dados bancários
    if request.method == "POST":
        acao = request.POST.get("acao")
        
        if acao == "criar" and not dados_bancarios:
            ConfiguracaoFinanceira.objects.create(
                nome_banco=request.POST.get("nome_banco"),
                titular_conta=request.POST.get("titular_conta"),
                numero_conta=request.POST.get("numero_conta"),
                iban=request.POST.get("iban"),
                swift=request.POST.get("swift"),
                instrucao_extra=request.POST.get("instrucao_extra")
            )
            messages.success(request, "Dados bancários criados com sucesso.")
            return redirect(request.path + "?secao=dados")

        elif acao == "editar" and dados_bancarios:
            dados_bancarios.nome_banco = request.POST.get("nome_banco")
            dados_bancarios.titular_conta = request.POST.get("titular_conta")
            dados_bancarios.numero_conta = request.POST.get("numero_conta")
            dados_bancarios.iban = request.POST.get("iban")
            dados_bancarios.swift = request.POST.get("swift")
            dados_bancarios.instrucao_extra = request.POST.get("instrucao_extra")
            dados_bancarios.save()
            messages.success(request, "Dados bancários atualizados com sucesso.")
            return redirect(request.path + "?secao=dados")

    # 📊 Relatório financeiro com filtros
    relatorio = []
    total_geral = 0

    if secao == "relatorio":
        relatorio_qs = PedidoMatricula.objects.filter(aprovado=True, pagamento_enviado=True).select_related("curso", "plano")

        # Filtros de data
        filtro_data = request.GET.get("periodo")  # valores: "mensal", "anual", "todos"
        hoje = timezone.now()

        if filtro_data == "mensal":
            relatorio_qs = relatorio_qs.filter(data_solicitacao__month=hoje.month, data_solicitacao__year=hoje.year)
        elif filtro_data == "anual":
            relatorio_qs = relatorio_qs.filter(data_solicitacao__year=hoje.year)

        # Agrupamento por curso
        from django.db.models import Sum, Count
        relatorio = (
            relatorio_qs.values("curso__nome")
            .annotate(
                total_pago=Sum("plano__preco"),
                total_alunos=Count("id")
            ).order_by("curso__nome")
        )
        total_geral = sum(item["total_pago"] or 0 for item in relatorio)

    return render(request, "financeiro/painel_financeiro.html", {
        "secao": secao,
        "planos": planos,
        "cursos": cursos,
        "dados_bancarios": dados_bancarios,
        "relatorio": relatorio,
        "total_geral": total_geral,
        "filtro_selecionado": request.GET.get("periodo", "todos"),
    })



@login_required
@user_passes_test(is_admin_or_superuser)
def criar_plano_view(request):
    if request.method == "POST":
        curso_id = request.POST.get("curso")
        duracao = request.POST.get("duracao")
        frequencia = request.POST.get("frequencia")
        preco = request.POST.get("preco")

        PlanoPrecoCurso.objects.create(
            curso_id=curso_id,
            duracao=duracao,
            frequencia=frequencia,
            preco=preco
        )

        messages.success(request, "Plano criado com sucesso.")
        return redirect("painel_financeiro")

@login_required
@user_passes_test(lambda u: u.is_superuser or u.is_admin)
def editar_plano_view(request, plano_id):
    plano = get_object_or_404(PlanoPrecoCurso, id=plano_id)

    if request.method == "POST":
        preco_raw = request.POST.get("preco").replace(",", ".")  # <- aqui
        try:
            preco_decimal = float(preco_raw)
        except ValueError:
            messages.error(request, "Preço inválido.")
            return redirect("editar_plano", plano_id=plano.id)

        plano.duracao = request.POST.get("duracao")
        plano.frequencia = request.POST.get("frequencia")
        plano.preco = preco_decimal
        plano.save()
        messages.success(request, "Plano atualizado com sucesso.")
        return redirect("painel_financeiro")

    return render(request, "financeiro/editar_plano.html", {"plano": plano})




@login_required
@user_passes_test(is_admin_or_superuser)
def deletar_plano_view(request, plano_id):
    plano = get_object_or_404(PlanoPrecoCurso, id=plano_id)
    plano.delete()
    messages.success(request, "Plano removido com sucesso.")
    return redirect("painel_financeiro")
