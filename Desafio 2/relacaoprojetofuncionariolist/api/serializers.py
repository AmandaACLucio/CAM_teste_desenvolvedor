from rest_framework.serializers import ModelSerializer
from relacaoprojetofuncionariolist.models import RelacaoProjetoFuncionario


class RelacaoProjetoFuncionarioSerializer(ModelSerializer):
    class Meta:
        model = RelacaoProjetoFuncionario
        fields = ('Relacao_id', 'Projeto', 'Funcionario', 'Carga_horaria')