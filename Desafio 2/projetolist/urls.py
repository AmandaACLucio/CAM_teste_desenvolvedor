
from django.urls import path

from . import views

urlpatterns = [
    path('api/projetos', views.ProjetoListView.as_view()),
    path('api/projetos/<int:Projeto_id>', views.ProjetoListView.as_view())
]