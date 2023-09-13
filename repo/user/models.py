from django.db import models

# Create your models here.
class User(models.Model):
  id = models.BigAutoField(primary_key=True)
  user_id = models.CharField(max_length=20, help_text="사용자 아이디", unique=True, blank=False)
  name = models.CharField(max_length=100, help_text="사용자 이름", blank=False)
  email = models.EmailField(help_text="사용자 이메일", blank=False)
  password = models.CharField(max_length=20, help_text="사용자 비밀번호", blank=False)
  created_at = models.DateTimeField(auto_now_add=True)
  last_join_at = models.DateTimeField(auto_now=True)
  