from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.mixins import UpdateModelMixin, DestroyModelMixin

from .models import Funcionario
from .serializers import FuncionarioSerializer


class FuncionarioListView(
    APIView,
    UpdateModelMixin,
    DestroyModelMixin,
    ):

    def get(self, request, Funcionario_id=None):
        if Funcionario_id:
            try:
                queryset = Funcionario.objects.get(Funcionario_id=Funcionario_id)
            
            except Funcionario.DoesNotExist:
                return Response({'errors': 'Este funcionário não existe.'}, status=400)
            
            read_serializer = FuncionarioSerializer(queryset)

        else:
            queryset = Funcionario.objects.all()
            read_serializer = FuncionarioSerializer(queryset, many=True)

        return Response(read_serializer.data)


    def post(self, request):

        create_serializer = FuncionarioSerializer(data=request.data)

        if create_serializer.is_valid():

            funcionario_item_object = create_serializer.save()
            read_serializer = FuncionarioSerializer(funcionario_item_object)

            return Response(read_serializer.data, status=201)

        return Response(create_serializer.errors, status=400)


    def put(self, request, Funcionario_id=None):

        try:
            funcionario_item = Funcionario.objects.get(Funcionario_id=Funcionario_id)
        except Funcionario.DoesNotExist:
            return Response({'errors': 'Este funcionário não existe.'}, status=400)

        update_serializer = FuncionarioSerializer(funcionario_item, data=request.data)

        if update_serializer.is_valid():

            funcionario_item_object = update_serializer.save()
            read_serializer = FuncionarioSerializer(funcionario_item_object)

            return Response(read_serializer.data, status=200)

        return Response(update_serializer.errors, status=400)


    def delete(self, request, Funcionario_id=None):
        try:
            funcionario_item = Funcionario.objects.get(Funcionario_id=Funcionario_id)
        except Funcionario.DoesNotExist:
            return Response({'errors': 'Este funcionário não existe.'}, status=400)

        funcionario_item.delete()

        return Response(status=204)
