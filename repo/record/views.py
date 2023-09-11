from django.shortcuts import render
from rest_framework.response import Response
from .models import Product, Record, RecordDetail
from rest_framework.views import APIView
from .serializers import ProductSerializer, RecordSerializer
from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi
class ProductListAPI(APIView):
  def get(self, request):
    queryset = Product.objects.all()
    
    serializer = ProductSerializer(queryset, many=True)
    return Response(serializer.data)

class RecordListAPI(APIView):
  user_id = openapi.Parameter('user_id', openapi.IN_PATH, description='user_id path', required=True, type=openapi.TYPE_STRING)
  
  @swagger_auto_schema(tags=['지정한 데이터의 상세 정보를 불러옵니다.'], manual_parameters=[user_id], responses={200: 'Success'})
  def get(self, request, user_id):
    queryset = Record.objects.all()
    
    serializer = RecordSerializer(queryset, many=True)
    return Response(serializer.data)