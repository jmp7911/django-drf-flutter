from rest_framework import serializers
from rest_framework.serializers import ModelSerializer
from .models import User

class UpdateUserSerializer(ModelSerializer.serializer):
  class Meta:
    model= User
    fields= '__all__'