from django.db import models

class Departamento(models.Model):
    
    Departamento_id = models.AutoField(primary_key=True)
    Nome = models.CharField(unique=True, max_length=200, null=False, blank=False)

    def __str__(self):
        return {"Nome": self.Nome}

    class Meta:
        db_table = 'Departamentos'
