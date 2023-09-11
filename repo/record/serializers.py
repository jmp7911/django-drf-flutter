from rest_framework import serializers
from .models import Product, Record, RecordDetail

class ProductSerializer(serializers.ModelSerializer) :
  class Meta :
    model = Product        # product 모델 사용
    fields = '__all__'

class RecordSerializer(serializers.ModelSerializer) :
  class Meta :
    model = Record        # product 모델 사용
    fields = '__all__'
