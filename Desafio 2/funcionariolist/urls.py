
from django.urls import path

from . import views

urlpatterns = [
    path('api/funcionarios', views.FuncionarioListView.as_view()),
    path('api/funcionarios/<int:Funcionario_id>', views.FuncionarioListView.as_view())
]