# Generated by Django 4.2.4 on 2023-10-20 02:02

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('accounts', '0003_alter_user_access_token_alter_user_expired_and_more'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='user',
            name='access_token',
        ),
        migrations.RemoveField(
            model_name='user',
            name='expired',
        ),
        migrations.RemoveField(
            model_name='user',
            name='refresh_token',
        ),
    ]
