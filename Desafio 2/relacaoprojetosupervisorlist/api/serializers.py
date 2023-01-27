from rest_framework.serializers import ModelSerializer
from relacaoprojetosupervisorlist.models import RelacaoProjetoSupervisor


class RelacaoProjetoSupervisorSerializer(ModelSerializer):
    class Meta:
        model = RelacaoProjetoSupervisor
        fields = ('Relacao_id', 'Projeto', 'Supervisor', 'Carga_horaria')