from django.shortcuts import render

from django.http import HttpResponse
from rest_framework.response import Response
from .models import Record, RecordDetail
from rest_framework.views import APIView
from .serializers import RecordSerializer, RecordDetailSerializer, path_user_id, RecordListSerializer, path_record_id
from drf_yasg.utils import swagger_auto_schema

from rest_framework.decorators import action
from django.utils.decorators import method_decorator
class RecordListAPI(APIView):
  @swagger_auto_schema(
    tags=['지정한 데이터의 리스트를 불러옵니다.'],manual_parameters=[path_user_id],responses={200: RecordListSerializer(many=True)}
  )
  def get(self, request, user_id):
    queryset = Record.objects.all()
    
    serializer = RecordSerializer(queryset, many=True)
    return Response(serializer.data)
class RecordDetailAPI(APIView):
  @swagger_auto_schema(
    tags=['지정한 데이터의 상세정보를 불러옵니다.'],manual_parameters=[path_record_id],responses={200: RecordDetailSerializer(many=True)}
  )
  def get(self, request, record_id):
    queryset = RecordDetail.objects.all()
    
    serializer = RecordDetailSerializer(queryset, many=True)
    return Response(serializer.data)
class RecordUpdateAPI(APIView):
  @swagger_auto_schema(
    tags=['지정한 데이터를 수정합니다.'],request_body=RecordSerializer,responses={200: 'Success'}
  )
  def put(self, request, user_id): 
    pass
class RecordDetailUpdateAPI(APIView):
  @swagger_auto_schema(
    tags=['지정한 데이터를 입력합니다.'],request_body=RecordDetailSerializer,responses={200: 'Success'}
  )
  def post(self, request, user_id): 
    pass
