from django.shortcuts import render
from rest_framework.response import Response
from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi
from rest_framework.views import APIView
from .serializer import UserSerializer, user_id

# Create your views here.
class UpdateUserAPI(APIView):
  @swagger_auto_schema(
    tags=['사용자의 데이터를 입력합니다.'], 
    request_body=UserSerializer, 
    responses={200: '성공'},
    operation_description='사용자의 데이터를 입력합니다. 있으면 수정합니다.'
    )
  def put(self, request):
    pass
    serializer = UserSerializer(data=request.data)
    if serializer.is_valid():
      serializer.save()
      return Response(serializer.data, status=200)
    return Response(serializer.errors, status=400)
class UserAPI(APIView):
  @swagger_auto_schema(
    tags=['사용자의 데이터를 조회합니다.'],
    manual_parameters=[user_id],
    operation_description='사용자의 데이터를 조회합니다.',
    responses={200: UserSerializer}
  )
  def get(self, request, user_id):
    pass
  