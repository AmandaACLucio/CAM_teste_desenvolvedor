from rest_framework.serializers import ModelSerializer
from relacaoprojetofuncionariolist.models import RelacaoProjetoFuncionario
from relacaoprojetosupervisorlist.models import RelacaoProjetoSupervisor


from rest_framework.exceptions import APIException

class RelacaoProjetoFuncionarioSerializer(ModelSerializer):
    class Meta:
        model = RelacaoProjetoFuncionario
        fields = ('Relacao_id', 'Projeto', 'Funcionario', 'Carga_horaria')