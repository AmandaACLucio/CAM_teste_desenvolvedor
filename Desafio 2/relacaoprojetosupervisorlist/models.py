from django.db import models
from funcionariolist.models import Funcionario
from projetolist.models import Projeto

class RelacaoProjetoSupervisor(models.Model):
    
    Relacao_id = models.AutoField(primary_key=True)
    Projeto = models.ForeignKey(Projeto , on_delete=models.CASCADE, unique=True)
    Supervisor = models.ForeignKey(Funcionario , on_delete=models.CASCADE)
    Carga_horaria = models.FloatField(null=False, blank=False)

    def __str__(self):
        return str({"Projeto_id": self.Projeto, "Supervisor_id": self.Supervisor, "Carga_horaria": self.Carga_horaria})

    class Meta:
        db_table = 'RelacoesProjetosSupervisores'    