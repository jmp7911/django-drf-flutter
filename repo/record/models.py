from django.db import models
# Create your models here.

class Product(models.Model):
  id = models.BigAutoField(primary_key=True)
  name = models.CharField(max_length=70)
  price = models.IntegerField()
  created_at = models.DateTimeField(auto_now_add=True)

  def __str__(self):
      return self.name
    
class Record(models.Model):
  id = models.BigAutoField(primary_key=True)
  user_id = models.CharField(max_length=20)
  reg_date_time = models.DateTimeField(auto_now_add=True)
  last_update_time = models.DateTimeField(auto_now=True)
  finish_time = models.DateTimeField(null=True)

class RecordDetail(models.Model):
  id = models.BigAutoField(primary_key=True)
  record_id = models.ForeignKey(Record, on_delete=models.CASCADE, help_text='Record 객체의 id')
  latitude = models.FloatField(default=0, help_text='위도')
  longitude = models.FloatField(default=0, help_text='경도')
  altitude = models.FloatField(default=0, help_text='고도')
  speed = models.FloatField(default=0, help_text='속도')
  created_at = models.DateTimeField(auto_now_add=True)
  
