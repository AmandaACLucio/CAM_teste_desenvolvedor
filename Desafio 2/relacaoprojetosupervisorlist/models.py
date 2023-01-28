from django.db import models
from funcionariolist.models import Funcionario
from projetolist.models import Projeto
from rest_framework.exceptions import APIException

class RelacaoProjetoSupervisor(models.Model):
    
    Relacao_id = models.AutoField(primary_key=True)
    Projeto = models.OneToOneField(Projeto , on_delete=models.CASCADE)
    Supervisor = models.ForeignKey(Funcionario , on_delete=models.CASCADE)
    Carga_horaria = models.FloatField(null=False, blank=False)   

    def save(self, *args, **kwargs):
    
        #Verificar se a carga_horaria total do funcionario não ultrapassa a carga_horária estabelecida para o dado funcionário
        
        if(self.Supervisor.Carga_horaria < self.Supervisor.Carga_horaria_exercida+self.Carga_horaria):
            raise APIException({"Erro": "A carga horária do funcionário ("+ str(self.Supervisor.Carga_horaria_exercida+self.Carga_horaria)+ ") ultrapassa a carga horária estabelecida para o mesmo ("+ str(self.Supervisor.Carga_horaria)+")"})
        else:
            self.Supervisor.Carga_horaria_exercida += self.Carga_horaria
            self.Supervisor.save()    
        
        super(RelacaoProjetoSupervisor, self).save(*args, **kwargs)

    def __str__(self):
        return str({"Projeto_id": self.Projeto, "Supervisor_id": self.Supervisor, "Carga_horaria": self.Carga_horaria})

    class Meta:
        db_table = 'RelacoesProjetosSupervisores'    