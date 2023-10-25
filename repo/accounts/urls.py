from django.contrib import admin
from django.urls import path, include
from record.views import RecordListAPI, RecordUpdateAPI, RecordDetailUpdateAPI, RecordDetailAPI

from . import views
from rest_framework import permissions
from drf_yasg.views import get_schema_view
from drf_yasg import openapi

urlpatterns = [
  path('login', views.login, name='login'),
  path('health', views.health),
  path('apikey', views.apikey),
]
