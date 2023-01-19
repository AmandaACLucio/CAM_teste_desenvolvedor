from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.mixins import UpdateModelMixin, DestroyModelMixin

from .models import Relacao
from .serializers import RelacaoSerializer


class RelacaoListView(
    APIView,
    UpdateModelMixin,
    DestroyModelMixin,
    ):

    def get(self, request, Relacao_id=None):
        if Relacao_id:
            try:
                queryset = Relacao.objects.get(Relacao_id=Relacao_id)
            
            except Relacao.DoesNotExist:
                return Response({'errors': 'Esta relacao não existe.'}, status=400)
            
            read_serializer = RelacaoSerializer(queryset)

        else:
            queryset = Relacao.objects.all()
            read_serializer = RelacaoSerializer(queryset, many=True)

        return Response(read_serializer.data)


    def post(self, request):

        create_serializer = RelacaoSerializer(data=request.data)

        if create_serializer.is_valid():

            relacao_item_object = create_serializer.save()
            read_serializer = RelacaoSerializer(relacao_item_object)

            return Response(read_serializer.data, status=201)

        return Response(create_serializer.errors, status=400)


    def put(self, request, Relacao_id=None):

        try:
            relacao_item = Relacao.objects.get(Relacao_id=Relacao_id)
        except Relacao.DoesNotExist:
            return Response({'errors': 'Esta relacao não existe.'}, status=400)

        update_serializer = RelacaoSerializer(relacao_item, data=request.data)

        if update_serializer.is_valid():

            relacao_item_object = update_serializer.save()
            read_serializer = RelacaoSerializer(relacao_item_object)

            return Response(read_serializer.data, status=200)

        return Response(update_serializer.errors, status=400)


    def delete(self, request, Relacao_id=None):
        try:
            relacao_item = Relacao.objects.get(Relacao_id=Relacao_id)
        except Relacao.DoesNotExist:
            return Response({'errors': 'Esta relacao não existe.'}, status=400)

        relacao_item.delete()

        return Response(status=204)