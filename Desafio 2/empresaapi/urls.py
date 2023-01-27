from funcionariolist.api.viewsets import FuncionarioViewSet
from departamentolist.api.viewsets import DepartamentoViewSet
from projetolist.api.viewsets import ProjetoViewSet
from relacaoprojetofuncionariolist.api.viewsets import RelacaoProjetoFuncionarioViewSet
from relacaoprojetosupervisorlist.api.viewsets import RelacaoProjetoSupervisorViewSet
from django.contrib import admin
from django.urls import path
from rest_framework import routers
from django.conf.urls import include

router = routers.DefaultRouter()
router.register(r'departamentos', DepartamentoViewSet)
router.register(r'funcionarios', FuncionarioViewSet)
router.register(r'projetos', ProjetoViewSet)
router.register(r'relacoesprojetosfuncionarios', RelacaoProjetoFuncionarioViewSet)
router.register(r'relacoesprojetossupervisores', RelacaoProjetoSupervisorViewSet)

urlpatterns = [
    path('api/', include(router.urls)),
    path('admin/', admin.site.urls),
]
