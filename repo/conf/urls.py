from django.contrib import admin
from django.urls import path, include
from record.views import RecordListAPI, RecordUpdateAPI, RecordDetailUpdateAPI, RecordDetailAPI
from rest_framework import permissions
from drf_yasg.views import get_schema_view
from drf_yasg import openapi
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
)

schema_view = get_schema_view(
    openapi.Info(
        title="프로젝트 이름(예: humanscape-project)",
        default_version='프로젝트 버전(예: 1.1.1)',
        description="해당 문서 설명(예: humanscape-project API 문서)",
        terms_of_service="https://www.google.com/policies/terms/",
        contact=openapi.Contact(email="이메일"), # 부가정보
        license=openapi.License(name="mit"),     # 부가정보
    ),
    public=True,
    permission_classes=[permissions.AllowAny],
)


urlpatterns = [
  path('admin/', admin.site.urls),

  path('api/record/<str:user_id>', RecordListAPI.as_view()),
  path('api/record/<str:user_id>/update', RecordUpdateAPI.as_view()),
  path('api/recordDetail/<int:record_id>/update', RecordDetailUpdateAPI.as_view()),
  path('api/recordDetail/<int:record_id>', RecordDetailAPI.as_view()),

  
  path(r'swagger(?P<format>\.json|\.yaml)', schema_view.without_ui(cache_timeout=0), name='schema-json'),
  path(r'swagger', schema_view.with_ui('swagger', cache_timeout=0), name='schema-swagger-ui'),
  path(r'redoc', schema_view.with_ui('redoc', cache_timeout=0), name='schema-redoc-v1'),
  # 이 아랫 부분은 우리가 사용하는 app들의 URL들을 넣습니다.
  path('record/', include('record.urls')),
  # 일반 회원 회원가입/로그인
  path('accounts/', include('allauth.urls')),
  path('api/user/', include('dj_rest_auth.urls')),
  path('api/user/registration/', include('dj_rest_auth.registration.urls')),
  
]
