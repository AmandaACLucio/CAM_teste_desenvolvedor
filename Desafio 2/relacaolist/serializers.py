from rest_framework import serializers

from .models import Relacao

class RelacaoSerializer(serializers.ModelSerializer):

    Projeto = serializers.IntegerField()
    Funcionario = serializers.IntegerField()
    Carga_horaria = serializers.FloatField()

    def create(self, validated_data):
        
        return Relacao.objects.create(
            Projeto=validated_data.get('Projeto_id'),
            Funcionario=validated_data.get('Funcionario_id'),
            Carga_horaria=validated_data.get('Carga_horaria')
        )


    def update(self, instance, validated_data):

        instance.Projeto = validated_data.get('Projeto_id', instance.Projeto),
        instance.Funcionario = validated_data.get('Funcionario_id', instance.Funcionario),
        instance.Carga_horaria = validated_data.get('Carga_horaria', instance.Carga_horaria)
        instance.save()
        return instance

    class Meta:
        model = Relacao
        fields = (
            'Relacao_id',
            'Projeto',
            'Funcionario',
            'Carga_horaria'
        )