from django.db import models
# Create your models here.

class Product(models.Model):
  name = models.CharField(max_length=70)
  price = models.IntegerField()
  created_at = models.DateTimeField(auto_now_add=True)

  def __str__(self):
      return self.name
    
class Record(models.Model):
  user_id = models.CharField(max_length=20)
  reg_date_time = models.DateTimeField(auto_now_add=True)
  last_update_time = models.DateTimeField(auto_now=True)
  finish_time = models.DateTimeField(null=True)

class RecordDetail(models.Model):
  record_id = models.ForeignKey(Record, on_delete=models.CASCADE)
  latitude = models.FloatField(default=0)
  longitude = models.FloatField(default=0)
  altitude = models.FloatField(default=0)
  speed = models.FloatField(default=0)
  created_at = models.DateTimeField(auto_now_add=True)
  
