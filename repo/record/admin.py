from django.contrib import admin
from .models import Product, Record, RecordDetail
# Register your models here.
admin.site.register(Product)
admin.site.register(Record)
admin.site.register(RecordDetail)