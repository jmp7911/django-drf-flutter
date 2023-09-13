from django.shortcuts import render
from rest_framework.response import Response
from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi
from rest_framework.views import APIView
from .serializer import UpdateUserSerializer

# Create your views here.
class UpdateUserAPI(APIView):
  @swagger_auto_schema(tags=['사용자의 데이터를 입력합니다.'], request_body=UpdateUserSerializer, responses={200: '성공'})
  def put(self, request):
    serializer = UpdateUserSerializer(data=request.data)
    if serializer.is_valid():
      serializer.save()
      return Response(serializer.data, status=200)
    return Response(serializer.errors, status=400)