from rest_framework import serializers

from .models import Projeto

class ProjetoSerializer(serializers.ModelSerializer):

    Departamento = serializers.IntegerField()
    Supervisor = serializers.IntegerField()
    Nome = serializers.CharField(max_length=200)
    Horas_conclusao = serializers.FloatField()
    Prazo_estimado = serializers.DateField()
    Horas_realizadas = serializers.FloatField()
    Ultimo_calculo_horas = serializers.DateField()

    def create(self, validated_data):
        
        return Projeto.objects.create(
            Departamento=validated_data.get('Departamento_id'),
            Supervisor=validated_data.get('Supervisor_id'),
            Nome=validated_data.get('Nome'),
            Horas_conclusao=validated_data.get('Horas_conclusao'),
            Prazo_estimado=validated_data.get('Prazo_estimado'),
            Horas_realizadas=validated_data.get('Horas_realizadas'),
            Ultimo_calculo_horas=validated_data.get('Ultimo_calculo_horas')
        )


    def update(self, instance, validated_data):
        # Once the request data has been validated, we can update the todo item instance in the database
        instance.Departamento = validated_data.get('Departamento_id', instance.Departamento),
        instance.Supervisor = validated_data.get('Supervisor_id', instance.Supervisor),
        instance.Nome = validated_data.get('Nome', instance.Nome),
        instance.Horas_conclusao = validated_data.get('Horas_conclusao', instance.Horas_conclusao),
        instance.Prazo_estimado = validated_data.get('Prazo_estimado', instance.Prazo_estimado),
        instance.Horas_realizadas = validated_data.get('Horas_realizadas', instance.Horas_realizadas),
        instance.Ultimo_calculo_horas = validated_data.get('Ultimo_calculo_horas', instance.Ultimo_calculo_horas)
        instance.save()
        return instance

    class Meta:
        model = Projeto
        fields = (
            'Projeto_id',
            'Departamento',
            'Supervisor',
            'Nome',
            'Horas_conclusao',
            'Prazo_estimado',
            'Horas_realizadas',
            'Ultimo_calculo_horas'
        )