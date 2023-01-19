from rest_framework import serializers
from rest_framework.validators import UniqueTogetherValidator

from .models import Funcionario

class FuncionarioSerializer(serializers.ModelSerializer):

    Nome = serializers.CharField(max_length=200, required=True)
    CPF = serializers.CharField(max_length=200, required=True)
    RG = serializers.CharField(max_length=200, required=True)
    Sexo = serializers.CharField(max_length=200, required=True)
    Data_nascimento = serializers.DateField()
    Possui_habilitacao = serializers.BooleanField()
    Salario = serializers.FloatField()
    Carga_horaria = serializers.FloatField()

    def create(self, validated_data):
        
        return Funcionario.objects.create(
            Nome=validated_data.get('Nome'),
            CPF=validated_data.get('CPF'),
            RG=validated_data.get('RG'),
            Sexo=validated_data.get('Sexo'),
            Data_nascimento=validated_data.get('Data_nascimento'),
            Possui_habilitacao=validated_data.get('Possui_habilitacao'),
            Salario=validated_data.get('Salario'),
            Carga_horaria=validated_data.get('Carga_horaria')        
        )


    def update(self, instance, validated_data):
        # Once the request data has been validated, we can update the todo item instance in the database
        instance.Nome = validated_data.get('Nome', instance.Nome)
        instance.CPF=validated_data.get('CPF',instance.CPF),
        instance.RG=validated_data.get('RG', instance.RG),
        instance.Sexo=validated_data.get('Sexo',instance.Sexo),
        instance.Data_nascimento=validated_data.get('Data_nascimento',instance.Data_nascimento),
        instance.Possui_habilitacao=validated_data.get('Possui_habilitacao', instance.Possui_habilitacao),
        instance.Salario=validated_data.get('Salario', instance.Salario),
        instance.Carga_horaria=validated_data.get('Carga_horaria', instance.Carga_horaria)   
        instance.save()
        return instance

    class Meta:
        model = Funcionario
        fields = (
            'Funcionario_id',
            'Nome',
            'CPF',
            'RG',
            'Sexo',
            'Data_nascimento',
            'Possui_habilitacao',
            'Salario',
            'Carga_horaria'
        )

        validators = [
            UniqueTogetherValidator(
                queryset=Funcionario.objects.all(),
                fields=['Nome', 'CPF', 'RG'],
                message="Já existe um funcionário com esse nome, CPF ou RG"
            )
        ]