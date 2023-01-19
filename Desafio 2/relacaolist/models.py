from django.db import models
from funcionariolist.models import Funcionario
from projetolist.models import Projeto

class Relacao(models.Model):
    
    Relacao_id = models.AutoField(primary_key=True)
    Projeto = models.ForeignKey(Projeto , on_delete=models.CASCADE)
    Funcionario = models.ForeignKey(Funcionario , on_delete=models.CASCADE)
    Carga_horaria = models.FloatField(null=False, blank=False)

    def __str__(self):
        return {"Projeto_id": self.Projeto, "Funcionario_id": self.Funcionario, "Carga_horaria": self.Carga_horaria}

    class Meta:
        db_table = 'Relacoes'    