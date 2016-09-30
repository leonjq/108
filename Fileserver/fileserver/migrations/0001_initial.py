# -*- coding: utf-8 -*-
# Generated by Django 1.9.4 on 2016-03-11 16:13
from __future__ import unicode_literals

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import fileserver.models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='File',
            fields=[
                ('auto_increment_id', models.AutoField(primary_key=True, serialize=False)),
                ('file', models.FileField(upload_to=fileserver.models.get_file_path)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='files', to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
