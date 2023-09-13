from rest_framework import serializers
from .models import User

class UserSerializer(serializers.ModelSerializer):
  user_id = serializers.CharField(max_length=20, help_text="사용자 아이디", required=True)
  name = serializers.CharField(max_length=100, help_text="사용자 이름", required=True)
  password = serializers.CharField(max_length=20, help_text="사용자 비밀번호", required=True)
  email = serializers.EmailField(help_text="사용자 이메일", required=True)
  last_join_at = serializers.DateTimeField()
  
  class Meta:
    model= User
    fields= '__all__'