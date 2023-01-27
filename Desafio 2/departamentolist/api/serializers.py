from rest_framework.serializers import ModelSerializer
from departamentolist.models import Departamento


class DepartamentoSerializer(ModelSerializer):
    class Meta:
        model = Departamento
        fields = ('Departamento_id', 'Nome')