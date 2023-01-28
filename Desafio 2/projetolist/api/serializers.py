from rest_framework.fields import SerializerMethodField
from rest_framework.serializers import ModelSerializer
from projetolist.models import Projeto
from datetime import datetime, date


class ProjetoSerializer(ModelSerializer):

    class Meta:
        model = Projeto
        fields = ('Projeto_id', 'Nome', 'Departamento', 'Horas_conclusao', 'Prazo_estimado', 'Horas_realizadas', 'Ultimo_calculo_horas' , 'Semanas_Passadas', 'Horas_totais_realizadas')
