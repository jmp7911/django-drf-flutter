from rest_framework import serializers
from .models import Product, Record, RecordDetail
from drf_yasg import openapi
user_id = openapi.Parameter('user_id', openapi.IN_PATH, description='user_id path', required=True, type=openapi.TYPE_STRING)

class ProductSerializer(serializers.ModelSerializer) :
  class Meta :
    model = Product        # product 모델 사용
    fields = '__all__'

class RecordSerializer(serializers.ModelSerializer) :
  id = serializers.IntegerField(help_text='Record 객체의 id')
  class Meta:
    model = Record
    fields = ['id']
class RecordDetailSerializer(serializers.ModelSerializer) :
  record_id = serializers.IntegerField(help_text='Record 객체의 id')
  latitude = serializers.FloatField(help_text='위도')
  longitude = serializers.FloatField(help_text='경도')
  altitude = serializers.FloatField(help_text='고도')
  speed = serializers.FloatField(help_text='속도')
  class Meta :
    model = RecordDetail
    fields = '__all__'
