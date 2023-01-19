from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.mixins import UpdateModelMixin, DestroyModelMixin

from .models import Projeto
from .serializers import ProjetoSerializer


class ProjetoListView(
    APIView,
    UpdateModelMixin,
    DestroyModelMixin,
    ):

    def get(self, request, Projeto_id=None):
        if Projeto_id:
            try:
                queryset = Projeto.objects.get(Projeto_id=Projeto_id)
            
            except Projeto.DoesNotExist:
                return Response({'errors': 'Este projeto não existe.'}, status=400)
            
            read_serializer = ProjetoSerializer(queryset)

        else:
            queryset = Projeto.objects.all()
            read_serializer = ProjetoSerializer(queryset, many=True)

        return Response(read_serializer.data)


    def post(self, request):

        create_serializer = ProjetoSerializer(data=request.data)

        if create_serializer.is_valid():

            projeto_item_object = create_serializer.save()
            read_serializer = ProjetoSerializer(projeto_item_object)

            return Response(read_serializer.data, status=201)

        return Response(create_serializer.errors, status=400)


    def put(self, request, Projeto_id=None):

        try:
            projeto_item = Projeto.objects.get(Projeto_id=Projeto_id)
        except Projeto.DoesNotExist:
            return Response({'errors': 'Este projeto não existe.'}, status=400)

        update_serializer = ProjetoSerializer(projeto_item, data=request.data)

        if update_serializer.is_valid():

            projeto_item_object = update_serializer.save()
            read_serializer = ProjetoSerializer(projeto_item_object)

            return Response(read_serializer.data, status=200)

        return Response(update_serializer.errors, status=400)


    def delete(self, request, Projeto_id=None):
        try:
            projeto_item = Projeto.objects.get(Projeto_id=Projeto_id)
        except Projeto.DoesNotExist:
            return Response({'errors': 'Este projeto não existe.'}, status=400)

        projeto_item.delete()

        return Response(status=204)