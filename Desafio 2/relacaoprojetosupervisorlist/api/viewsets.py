from .serializers import RelacaoProjetoSupervisorSerializer
from rest_framework import viewsets
from relacaoprojetosupervisorlist.models import RelacaoProjetoSupervisor
    
class RelacaoProjetoSupervisorViewSet(viewsets.ModelViewSet):
    queryset = RelacaoProjetoSupervisor.objects.all()
    serializer_class = RelacaoProjetoSupervisorSerializer