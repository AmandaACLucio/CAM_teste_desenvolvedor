from django.db import models
from funcionariolist.models import Funcionario
from projetolist.models import Projeto
from datetime import datetime, date
from rest_framework.exceptions import APIException

class RelacaoProjetoFuncionario(models.Model):
    
    Relacao_id = models.AutoField(primary_key=True)
    Projeto = models.ForeignKey(Projeto , on_delete=models.CASCADE)
    Funcionario = models.ForeignKey(Funcionario , on_delete=models.CASCADE)
    Carga_horaria = models.FloatField(null=False, blank=False)

    def save(self, *args, **kwargs):

        #Verificar se a carga_horaria total do funcionario não ultrapassa a carga_horária estabelecida para o dado funcionário
        
        if(self.Funcionario.Carga_horaria < self.Funcionario.Carga_horaria_exercida+self.Carga_horaria):
            raise APIException({"Erro": "A carga horária do funcionário ("+ str(self.Funcionario.Carga_horaria_exercida+self.Carga_horaria)+ ") ultrapassa a carga horária estabelecida para o mesmo ("+ str(self.Funcionario.Carga_horaria)+")"})
        
        self.Funcionario.Carga_horaria_exercida += self.Carga_horaria

        #Atualizando a tabela de projetos

        if(self.Projeto.Horas_conclusao-self.Carga_horaria < 0):
            raise APIException({"Erro": "A carga horária da relação ultrapassa a carga horária restante para conclusão do projeto"})

        #Atualizando data do último cálculo
        self.Projeto.Ultimo_calculo_horas = date.today()

        #Atualizando horas realizadas, horas totais realizadas e horas restantes para conclusão
        self.Projeto.Horas_totais_realizadas += self.Carga_horaria
        self.Projeto.Horas_realizadas = self.Projeto.Horas_totais_realizadas/self.Projeto.Semanas_Passadas
        self.Projeto.Horas_conclusao -= self.Carga_horaria

        self.Funcionario.save()            
        self.Projeto.save()

        super(RelacaoProjetoFuncionario, self).save(*args, **kwargs)

    def __str__(self):
        return str({"Projeto_id": self.Projeto, "Funcionario_id": self.Funcionario, "Carga_horaria": self.Carga_horaria})

    class Meta:
        db_table = 'RelacoesProjetosFuncionarios'    