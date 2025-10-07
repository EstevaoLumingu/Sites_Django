from nivelamento.models import QuizPergunta, QuizResposta
from courses.models import Course
from django.db import transaction

# 🔁 Evita duplicar se rodar mais de uma vez
QuizPergunta.objects.all().delete()
print("🧹 Perguntas antigas apagadas.")

# ⚙️ Dados simulados por curso e nível
sample_data = {
    "Inglês": {
        "iniciante": [
            {
                "pergunta": "What is the correct form of the verb: 'I ___ a student.'",
                "respostas": ["is", "am", "are", "be"],
                "correta": "am"
            },
            {
                "pergunta": "Select the correct plural: 'One cat, two ___.'.",
                "respostas": ["cats", "cat", "cates", "catt"],
                "correta": "cats"
            }
        ],
        "intermedio": [
            {
                "pergunta": "Choose the correct option: 'She has lived in London ___ 2010.'",
                "respostas": ["for", "since", "from", "by"],
                "correta": "since"
            }
        ],
        "avancado": [
            {
                "pergunta": "What is the passive voice of: 'They built the house in 2001.'",
                "respostas": [
                    "The house was built in 2001.",
                    "The house is built in 2001.",
                    "They build the house in 2001.",
                    "The house has been built in 2001."
                ],
                "correta": "The house was built in 2001."
            }
        ],
        "fluente": [
            {
                "pergunta": "Identify the correct reported speech: 'He said: I will go there.'",
                "respostas": [
                    "He said he would go there.",
                    "He says he would go there.",
                    "He told he will go there.",
                    "He said I would go there."
                ],
                "correta": "He said he would go there."
            }
        ]
    },

    "Português": {
        "iniciante": [
            {
                "pergunta": "Qual é o plural de 'cão'?",
                "respostas": ["cãos", "cães", "cões", "cãones"],
                "correta": "cães"
            }
        ],
        "intermedio": [
            {
                "pergunta": "Identifica o verbo no pretérito: 'Eu ___ muito ontem.'",
                "respostas": ["corri", "corro", "corria", "correr"],
                "correta": "corri"
            }
        ],
        "avancado": [
            {
                "pergunta": "Assinale a alternativa com uso correto do 'por que':",
                "respostas": [
                    "Não sei por que você saiu.",
                    "Por que você saiu.",
                    "Você saiu por quê.",
                    "Porque você saiu?"
                ],
                "correta": "Não sei por que você saiu."
            }
        ],
        "fluente": [
            {
                "pergunta": "Qual das frases tem sentido figurado?",
                "respostas": [
                    "Ele está na linha de frente da luta.",
                    "Ele está em frente à escola.",
                    "Ele caminha na linha.",
                    "Ele risca a linha no chão."
                ],
                "correta": "Ele está na linha de frente da luta."
            }
        ]
    }
}


@transaction.atomic
def run():
    total = 0
    for nome_curso, niveis in sample_data.items():
        curso, _ = Course.objects.get_or_create(nome=nome_curso, defaults={'descricao': f'Curso de {nome_curso}'})
        for nivel, perguntas in niveis.items():
            for p in perguntas:
                pergunta_obj = QuizPergunta.objects.create(
                    curso=curso,
                    nivel=nivel,
                    pergunta=p["pergunta"]
                )
                for texto in p["respostas"]:
                    QuizResposta.objects.create(
                        pergunta=pergunta_obj,
                        texto=texto,
                        correta=(texto == p["correta"])
                    )
                total += 1
    print(f"✅ Inserido {total} perguntas com sucesso.")
