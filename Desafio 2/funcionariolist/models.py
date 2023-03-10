from django.db import models

class Funcionario(models.Model):
    
    Funcionario_id = models.AutoField(primary_key=True)
    Nome = models.CharField(unique=True, max_length=200, null=False, blank=False)
    CPF = models.CharField(unique=True, max_length=200, null=False, blank=False)
    RG = models.CharField(unique=True, max_length=200, null=False, blank=False)
    Sexo = models.CharField(max_length=200, null=False, blank=False)
    Data_nascimento = models.DateField(null=False, blank=False)
    Possui_habilitacao = models.BooleanField(null=False, blank=False)
    Salario = models.FloatField(null=False, blank=False)
    Carga_horaria = models.FloatField(null=False, blank=False)
    Carga_horaria_exercida = models.FloatField(default= 0, blank=False)

    def __str__(self):
        return str({"Nome": self.Nome, "CPF": self.CPF, "RG": self.RG, "Sexo": self.Sexo, "Data_nascimento": self.Data_nascimento, "Possui_habilitacao": self.Possui_habilitacao, "Salario": self.Salario, "Carga_horaria": self.Carga_horaria, "Carga_horaria_exercida": self.Carga_horaria_exercida})

    class Meta:
        db_table = 'Funcionarios'