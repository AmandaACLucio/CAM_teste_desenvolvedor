from .serializers import ProjetoSerializer
from rest_framework import viewsets
from projetolist.models import Projeto
    
class ProjetoViewSet(viewsets.ModelViewSet):
    queryset = Projeto.objects.all()
    serializer_class = ProjetoSerializer
