
from django.urls import path

from . import views

urlpatterns = [
    path('api/departamentos', views.DepartamentoListView.as_view()),
    path('api/departamentos/<int:Departamento_id>', views.DepartamentoListView.as_view())
]