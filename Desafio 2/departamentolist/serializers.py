from rest_framework import serializers

from .models import Departamento

class DepartamentoSerializer(serializers.ModelSerializer):

    Nome = serializers.CharField(max_length=200, required=True)

    def create(self, validated_data):
        return Departamento.objects.create(
            Nome=validated_data.get('Nome')
        )

    def update(self, instance, validated_data):
        # Once the request data has been validated, we can update the todo item instance in the database
        instance.Nome = validated_data.get('Nome', instance.Nome)
        instance.save()
        return instance

    class Meta:
        model = Departamento
        fields = (
            'Departamento_id',
            'Nome'
        )