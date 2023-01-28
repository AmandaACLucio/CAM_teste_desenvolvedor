from django.db import models
from departamentolist.models import Departamento
from datetime import datetime, date

class Projeto(models.Model):
    
    Projeto_id = models.AutoField(primary_key=True)
    Departamento = models.ForeignKey(Departamento , on_delete=models.CASCADE)
    Nome = models.CharField(unique=True, max_length=200, null=False, blank=False)
    Horas_conclusao = models.FloatField(null=False, blank=False)
    Prazo_estimado = models.DateField(null=False, blank=False)
    Horas_realizadas = models.FloatField(default=0, blank=False)
    Ultimo_calculo_horas = models.DateField(auto_now_add=True, null=False, blank=False)
    Horas_totais_realizadas = models.FloatField(default=0, blank=False)

    @property
    def Semanas_Passadas(self):
        #quantas semanas passaram desde o ultimo_calculo_horas
        dateNow = date.today()
        dateLast = self.Ultimo_calculo_horas
        delta = (dateNow - dateLast).days/7
        delta = 1 if delta < 1 else delta
        return delta

    def __str__(self):
        return str({"Departamento_id": self.Departamento, "Nome": self.Nome})

    class Meta:
        db_table = 'Projetos'    
