from django.db import models
from funcionariolist.models import Funcionario
from projetolist.models import Projeto
from rest_framework.exceptions import APIException

class RelacaoProjetoSupervisor(models.Model):
    
    Relacao_id = models.AutoField(primary_key=True)
    Projeto = models.OneToOneField(Projeto , on_delete=models.CASCADE)
    Supervisor = models.ForeignKey(Funcionario , on_delete=models.CASCADE)
    Carga_horaria = models.FloatField(null=False, blank=False)   

    #Função que caso o verbo seja DELETE, atualiza a carga horária exercida do funcionário e a carga horária restante do projeto
    def delete(self, *args, **kwargs):
            
        supervisor = Funcionario.objects.get(Funcionario_id=self.Supervisor.Funcionario_id)

        supervisor.Carga_horaria_exercida -= self.Carga_horaria 
        supervisor.save()

        super(RelacaoProjetoSupervisor, self).delete(*args, **kwargs)



    def save(self, *args, **kwargs):
    
        supervisor = Funcionario.objects.get(Funcionario_id=self.Supervisor.Funcionario_id)

        #Verificar se a carga_horaria total do funcionario não ultrapassa a carga_horária estabelecida para o dado funcionário

        if (self.Relacao_id==None):
    
            if(supervisor.Carga_horaria < supervisor.Carga_horaria_exercida+self.Carga_horaria):
                raise APIException({"Erro": "A carga horária do funcionário ("+ str(supervisor.Carga_horaria_exercida+self.Carga_horaria)+ ") ultrapassa a carga horária estabelecida para o mesmo ("+ str(supervisor.Carga_horaria)+")"})
            
            supervisor.Carga_horaria_exercida += self.Carga_horaria
  
        else:

            relacao = RelacaoProjetoSupervisor.objects.get(Relacao_id=self.Relacao_id)

            if(supervisor.Carga_horaria < (supervisor.Carga_horaria_exercida+self.Carga_horaria-relacao.Carga_horaria)):
                raise APIException({"Erro": "A carga horária do funcionário ("+ str(supervisor.Carga_horaria_exercida+self.Carga_horaria-relacao.Carga_horaria)+ ") ultrapassa a carga horária estabelecida para o mesmo ("+ str(supervisor.Carga_horaria)+")"})
            
            supervisor.Carga_horaria_exercida += self.Carga_horaria-relacao.Carga_horaria
        
        supervisor.save()         
        super(RelacaoProjetoSupervisor, self).save(*args, **kwargs)

    def __str__(self):
        return str({"Projeto_id": self.Projeto, "Supervisor_id": self.Supervisor, "Carga_horaria": self.Carga_horaria})

    class Meta:
        db_table = 'RelacoesProjetosSupervisores'    