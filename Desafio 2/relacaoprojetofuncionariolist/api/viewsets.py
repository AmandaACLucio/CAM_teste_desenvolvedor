from .serializers import RelacaoProjetoFuncionarioSerializer
from rest_framework import viewsets
from relacaoprojetofuncionariolist.models import RelacaoProjetoFuncionario
    
class RelacaoProjetoFuncionarioViewSet(viewsets.ModelViewSet):
    queryset = RelacaoProjetoFuncionario.objects.all()
    serializer_class = RelacaoProjetoFuncionarioSerializer