import json
from django.shortcuts import render, redirect
from rest_framework.response import Response
from drf_yasg.utils import swagger_auto_schema
from rest_framework.views import APIView
from django.contrib.auth import authenticate
from django.contrib.auth.models import User
from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponse
from rest_framework.permissions import IsAuthenticated
from rest_framework_api_key.models import APIKey
from rest_framework.decorators import api_view, permission_classes
from datetime import datetime, timedelta
from rest_framework import status
from rest_framework_api_key.permissions import HasAPIKey

@api_view(['POST'])
@csrf_exempt
def login(request):
  if request.method == "POST":
    
    data = json.loads(request.body)
    
    username = data['email']
    password = data['password']
    user = authenticate(request, username=username, password=password)
    if user is not None:
        return HttpResponse(user)
    else:
        return HttpResponse('로그인 실패. 다시 시도 해보세요.')
  else:
    pass
  return HttpResponse('b')

@api_view(['GET', 'POST'])  
@csrf_exempt
@permission_classes([IsAuthenticated])
def apikey(request):
    username = request.user.username
    if request.method == 'GET':
        response = {}
        keys = APIKey.objects.all()
        for key in keys:
            if key.name == username:
                response['apikey'] = key.prefix + '*****'
                response['created'] = key.created
                response['expires'] = key.expiry_date
                break
        return Response(response, status=status.HTTP_200_OK)
    else:
        keys = APIKey.objects.all()
        for key in keys:
            if key.name == username:
                key.delete()
                break
        api_key, key = APIKey.objects.create_key(name=request.user.username)
        expires = datetime.now() + timedelta(days=90)
        api_key.expiry_date = expires
        api_key.save()
        return Response({'apikey': key, 'expires': expires}, status=status.HTTP_200_OK)
      
@api_view(['GET'])      
@csrf_exempt      
def health(request):
    return Response({'message': 'OK'}, status=status.HTTP_200_OK)