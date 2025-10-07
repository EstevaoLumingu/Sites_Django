from django import forms
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from .models import CustomUser

class CustomUserCreationForm(UserCreationForm):
    first_name = forms.CharField(
        label="Nome",
        required=True,
        widget=forms.TextInput(attrs={'placeholder': 'Seu nome'})
    )
    last_name = forms.CharField(
        label="Sobrenome",
        required=True,
        widget=forms.TextInput(attrs={'placeholder': 'Seu sobrenome'})
    )
    especialidade = forms.CharField(
        label="Especialidade",
        required=False,  # importante: sempre False no formulário!
        widget=forms.TextInput(attrs={'placeholder': 'Sua especialidade'})
    )

    class Meta:
        model = CustomUser
        fields = [
            'username',
            'first_name',
            'last_name',
            'email',
            'categoria',
            'grau_academico',
            'especialidade',
            'password1',
            'password2',
        ]

    def clean(self):
        cleaned_data = super().clean()
        categoria = cleaned_data.get('categoria')
        especialidade = cleaned_data.get('especialidade')

        # Regra: se professor, deve preencher especialidade
        if categoria == 'professor':
            if not especialidade:
                self.add_error('especialidade', 'Campo especialidade é obrigatório para professores.')
        else:
            # Se não for professor, apaga qualquer valor enviado
            cleaned_data['especialidade'] = ''

        return cleaned_data


class CustomLoginForm(AuthenticationForm):
    username = forms.CharField(label="Nome de Utilizador")
    password = forms.CharField(label="Palavra-passe", widget=forms.PasswordInput)

class CustomUserAdminEditForm(forms.ModelForm):
    class Meta:
        model = CustomUser
        fields = [
            'first_name', 'last_name', 'email', 'categoria',
            'grau_academico', 'tipo_acesso', 'is_active'
        ]


from django import forms
from .models import CustomUser

class PerfilUpdateForm(forms.ModelForm):
    class Meta:
        model = CustomUser
        fields = [
            'foto_perfil', 'first_name', 'last_name', 'email',
            'phone_number', 'address', 'categoria', 'grau_academico',
            'especialidade'
        ]
        widgets = {
            'first_name': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Nome'}),
            'last_name': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Sobrenome'}),
            'email': forms.EmailInput(attrs={'class': 'form-control', 'placeholder': 'Email'}),
            'phone_number': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Número de telefone'}),
            'address': forms.Textarea(attrs={'class': 'form-control', 'rows': 2, 'placeholder': 'Endereço'}),
            'categoria': forms.Select(attrs={'class': 'form-select'}),
            'grau_academico': forms.Select(attrs={'class': 'form-select'}),
            'especialidade': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Especialidade'}),
        }
