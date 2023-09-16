from rest_framework import serializers
from .models import Product, Record, RecordDetail
from drf_yasg import openapi

path_user_id = openapi.Parameter('user_id', openapi.IN_PATH, description='사용자 id path', required=True, type=openapi.TYPE_STRING)
path_record_id = openapi.Parameter('record_id', openapi.IN_PATH, description='기록 id', required=True, type=openapi.TYPE_INTEGER)

class RecordDetailSerializer(serializers.ModelSerializer) :
  record_id = serializers.IntegerField(help_text='Record 객체의 id')
  latitude = serializers.FloatField(help_text='위도')
  longitude = serializers.FloatField(help_text='경도')
  altitude = serializers.FloatField(help_text='고도')
  speed = serializers.FloatField(help_text='속도')
  class Meta :
    model = RecordDetail
    fields = '__all__'
class RecordSerializer(serializers.ModelSerializer) :
  id = serializers.IntegerField(help_text='Record 객체의 id')
  last_update_time = serializers.DateTimeField(help_text='마지막으로 업데이트된 시간')
  reg_date_time = serializers.DateTimeField(help_text='생성된 시간')
  finish_time = serializers.DateTimeField(help_text='종료된 시간')
  record = RecordDetailSerializer(many=True)
  
  class Meta:
    model = Record
    fields = '__all__'

class RecordListSerializer(serializers.ModelSerializer):
  id = serializers.IntegerField(help_text='Record 객체의 id')
  finish_time = serializers.DateTimeField(help_text='종료된 시간')
  distance = serializers.FloatField(help_text='이동 거리')
  record = serializers.TimeField(help_text='기록 시간')
  
  class Meta:
    model = Record
    fields = '__all__'
