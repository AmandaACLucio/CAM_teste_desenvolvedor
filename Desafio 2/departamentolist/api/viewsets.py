from .serializers import DepartamentoSerializer
from rest_framework import viewsets
from departamentolist.models import Departamento
    
class DepartamentoViewSet(viewsets.ModelViewSet):
    queryset = Departamento.objects.all()
    serializer_class = DepartamentoSerializer