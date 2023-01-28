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

    #Função que caso o verbo seja DELETE, atualiza a carga horária exercida do funcionário e a carga horária restante do projeto
    def delete(self, *args, **kwargs):
        
        funcionario = Funcionario.objects.get(Funcionario_id=self.Funcionario.Funcionario_id)
        projeto = Projeto.objects.get(Projeto_id=self.Projeto.Projeto_id)

        funcionario.Carga_horaria_exercida -= self.Carga_horaria
        projeto.Horas_conclusao += self.Carga_horaria
        projeto.Horas_totais_realizadas -= self.Carga_horaria
        projeto.Horas_realizadas = projeto.Horas_totais_realizadas/projeto.Semanas_Passadas
        projeto.Ultimo_calculo_horas = date.today()    
        funcionario.save()
        projeto.save()

        super(RelacaoProjetoFuncionario, self).delete(*args, **kwargs)

    def save(self, *args, **kwargs):

        funcionario = Funcionario.objects.get(Funcionario_id=self.Funcionario.Funcionario_id)
        projeto = Projeto.objects.get(Projeto_id=self.Projeto.Projeto_id)

        #Verificar se o funcionário já está alocado no projeto
        if (self.Relacao_id==None):

            #Verificar se a carga_horaria total do funcionario não ultrapassa a carga_horária estabelecida para o dado funcionário
            
            if(funcionario.Carga_horaria < funcionario.Carga_horaria_exercida+self.Carga_horaria):
                raise APIException({"Erro": "A carga horária do funcionário ("+ str(self.Funcionario.Carga_horaria_exercida+self.Carga_horaria)+ ") ultrapassa a carga horária estabelecida para o mesmo ("+ str(self.Funcionario.Carga_horaria)+")"})
            

            #Atualizando a tabela de projetos

            if(projeto.Horas_conclusao-self.Carga_horaria < 0):
                raise APIException({"Erro": "A carga horária da relação ultrapassa a carga horária restante para conclusão do projeto"})

            #Atualizando a carga horária exercida do funcionario
            funcionario.Carga_horaria_exercida += self.Carga_horaria

            #Atualizando horas realizadas, horas totais realizadas e horas restantes para conclusão
            projeto.Horas_totais_realizadas += self.Carga_horaria
            projeto.Horas_realizadas = projeto.Horas_totais_realizadas/projeto.Semanas_Passadas
            projeto.Horas_conclusao -= self.Carga_horaria

            #Atualizando data do último cálculo
            projeto.Ultimo_calculo_horas = date.today()

        else:

            relacao = RelacaoProjetoFuncionario.objects.get(Relacao_id=self.Relacao_id)
            #Verificar se a carga_horaria total do funcionario não ultrapassa a carga_horária estabelecida para o dado funcionário
            if(funcionario.Carga_horaria < (funcionario.Carga_horaria_exercida+self.Carga_horaria-relacao.Carga_horaria)):
                raise APIException({"Erro": "A carga horária do funcionário ("+ str(funcionario.Carga_horaria_exercida+self.Carga_horaria-relacao.Carga_horaria)+ ") ultrapassa a carga horária estabelecida para o mesmo ("+ str(funcionario.Carga_horaria)+")"})

            #Atualizando a tabela de projetos

            if(projeto.Horas_conclusao-self.Carga_horaria+relacao.Carga_horaria < 0):
                raise APIException({"Erro": "A carga horária da relação ultrapassa a carga horária restante para conclusão do projeto"})

            #Atualizando a carga horária exercida do funcionario
            funcionario.Carga_horaria_exercida += self.Carga_horaria-relacao.Carga_horaria

            #Atualizando horas realizadas, horas totais realizadas e horas restantes para conclusão
            projeto.Horas_totais_realizadas += self.Carga_horaria-relacao.Carga_horaria
            projeto.Horas_realizadas = projeto.Horas_totais_realizadas/projeto.Semanas_Passadas
            projeto.Horas_conclusao -= self.Carga_horaria+relacao.Carga_horaria

            #Atualizando data do último cálculo
            projeto.Ultimo_calculo_horas = date.today()

        funcionario.save()            
        projeto.save()

        super(RelacaoProjetoFuncionario, self).save(*args, **kwargs)

    def __str__(self):
        return str({"Projeto_id": self.Projeto, "Funcionario_id": self.Funcionario, "Carga_horaria": self.Carga_horaria})

    class Meta:
        db_table = 'RelacoesProjetosFuncionarios'    