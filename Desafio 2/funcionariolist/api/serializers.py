from rest_framework.serializers import ModelSerializer
from funcionariolist.models import Funcionario


class FuncionarioSerializer(ModelSerializer):
    class Meta:
        model = Funcionario
        fields = ('Funcionario_id', 'Nome', 'CPF', 'RG', 'Sexo', 'Data_nascimento', 'Possui_habilitacao', 'Salario', 'Carga_horaria', 'Carga_horaria_exercida')