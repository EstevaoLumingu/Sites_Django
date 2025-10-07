import json
import os
from django.core.management.base import BaseCommand
from django.db import transaction
from nivelamento.models import QuizPergunta, QuizResposta
from courses.models import Course


class Command(BaseCommand):
    help = 'Importa perguntas de nivelamento a partir de um JSON local'

    def handle(self, *args, **kwargs):
        caminho = os.path.join('nivelamento', 'data', 'perguntas_nivelamento.json')

        if not os.path.exists(caminho):
            self.stderr.write("❌ Arquivo não encontrado.")
            return

        with open(caminho, 'r', encoding='utf-8') as f:
            dados = json.load(f)

        with transaction.atomic():
            QuizPergunta.objects.all().delete()

            count = 0
            for item in dados:
                curso_nome = item["curso"]
                curso, _ = Course.objects.get_or_create(nome=curso_nome, defaults={"descricao": f"Curso de {curso_nome}"})

                pergunta = QuizPergunta.objects.create(
                    curso=curso,
                    nivel=item["nivel"],
                    pergunta=item["pergunta"]
                )

                for r in item["respostas"]:
                    QuizResposta.objects.create(
                        pergunta=pergunta,
                        texto=r["texto"],
                        correta=r["correta"]
                    )

                count += 1

        self.stdout.write(self.style.SUCCESS(f"✅ {count} perguntas importadas com sucesso!"))
