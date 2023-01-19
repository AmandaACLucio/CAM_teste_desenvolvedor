from django.db import models

class Funcionario(models.Model):
    
    Funcionario_id = models.AutoField(primary_key=True)
    Nome = models.CharField(unique=True, max_length=200, null=False, blank=False)
    CPF = models.CharField(unique=True, max_length=200, null=False, blank=False)
    RG = models.CharField(unique=True, max_length=200, null=False, blank=False)
    Sexo = models.CharField(unique=True, max_length=200, null=False, blank=False)
    Data_nascimento = models.DateField(null=False, blank=False)
    Possui_habilitacao = models.BooleanField(null=False, blank=False)
    Salario = models.FloatField(null=False, blank=False)
    Carga_horaria = models.FloatField(null=False, blank=False)

    def __str__(self):
        return {"Nome": self.Nome}

    class Meta:
        db_table = 'Funcionarios'
