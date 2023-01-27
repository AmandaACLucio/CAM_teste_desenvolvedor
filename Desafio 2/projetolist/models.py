from django.db import models
from departamentolist.models import Departamento
from funcionariolist.models import Funcionario

class Projeto(models.Model):
    
    Projeto_id = models.AutoField(primary_key=True)
    Departamento = models.ForeignKey(Departamento , on_delete=models.CASCADE)
    Nome = models.CharField(unique=True, max_length=200, null=False, blank=False)
    Horas_conclusao = models.FloatField(null=False, blank=False)
    Prazo_estimado = models.DateField(null=False, blank=False)
    Horas_realizadas = models.FloatField(null=False, blank=False)
    Ultimo_calculo_horas = models.DateField(auto_now_add=True, null=False, blank=False)

    def __str__(self):
        return str({"Departamento_id": self.Departamento, "Nome": self.Nome})

    class Meta:
        db_table = 'Projetos'    
