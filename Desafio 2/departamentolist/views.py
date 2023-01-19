from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.mixins import UpdateModelMixin, DestroyModelMixin

from .models import Departamento
from .serializers import DepartamentoSerializer


class DepartamentoListView(
    APIView,
    UpdateModelMixin,
    DestroyModelMixin,
    ):

    def get(self, request, Departamento_id=None):
        if Departamento_id:
            try:
                queryset = Departamento.objects.get(Departamento_id=Departamento_id)
            
            except Departamento.DoesNotExist:
                return Response({'errors': 'Este departamento não existe.'}, status=400)
            
            read_serializer = DepartamentoSerializer(queryset)

        else:
            queryset = Departamento.objects.all()
            read_serializer = DepartamentoSerializer(queryset, many=True)

        return Response(read_serializer.data)


    def post(self, request):

        create_serializer = DepartamentoSerializer(data=request.data)

        if create_serializer.is_valid():

            departamento_item_object = create_serializer.save()
            read_serializer = DepartamentoSerializer(departamento_item_object)

            return Response(read_serializer.data, status=201)

        return Response(create_serializer.errors, status=400)


    def put(self, request, Departamento_id=None):

        try:
            departamento_item = Departamento.objects.get(Departamento_id=Departamento_id)
        except Departamento.DoesNotExist:
            return Response({'errors': 'Este departamento não existe.'}, status=400)

        update_serializer = DepartamentoSerializer(departamento_item, data=request.data)

        if update_serializer.is_valid():

            departamento_item_object = update_serializer.save()
            read_serializer = DepartamentoSerializer(departamento_item_object)

            return Response(read_serializer.data, status=200)

        return Response(update_serializer.errors, status=400)


    def delete(self, request, Departamento_id=None):
        try:
            departamento_item = Departamento.objects.get(Departamento_id=Departamento_id)

        except Departamento.DoesNotExist:
            return Response({'errors': 'Este departamento não existe.'}, status=400)

        departamento_item.delete()

        return Response({'sucesso': "item %d deletado com sucesso"% Departamento_id},status=204)