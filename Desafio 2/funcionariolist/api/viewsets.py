from .serializers import FuncionarioSerializer
from rest_framework import viewsets
from funcionariolist.models import Funcionario
    
class FuncionarioViewSet(viewsets.ModelViewSet):
    queryset = Funcionario.objects.all()
    serializer_class = FuncionarioSerializer