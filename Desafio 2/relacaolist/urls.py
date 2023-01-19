
from django.urls import path

from . import views

urlpatterns = [
    path('api/relacoes', views.RelacaoListView.as_view()),
    path('api/relacoes/<int:Relacao_id>', views.RelacaoListView.as_view())
]