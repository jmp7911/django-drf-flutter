from django.test import TestCase
from .models import User
# Create your tests here.

for user in User.objects.values():
  print(user)

# uesr = User.objects.create_user('test2@example.com', '12345678!')
# print(uesr)