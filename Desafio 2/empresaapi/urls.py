from django.contrib import admin
from django.urls import path,include


urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('departamentolist.urls')),
    path('', include('funcionariolist.urls')),
    path('', include('projetolist.urls')),
    path('', include('relacaolist.urls'))
]