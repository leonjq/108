from django.contrib.auth.models import User
from django.db import models
import os
from django.shortcuts import render
from django.http import HttpResponseRedirect

#instance is file model
def get_file_path(instance, filename):
    return os.path.join(str(instance.user.id), filename)

def Filedownload(request):
    pass

class Fileupload(models.Model):
    auto_increment_id = models.AutoField(primary_key=True)
    user = models.ForeignKey(User, related_name='files') #file is tied to a user; user can access all files through the column 'files'
    file = models.FileField(upload_to=get_file_path) #file location, django passes in parameters to get file path

class encode(models.Model):
    id = models.AutoField
    oldname = models.CharField(max_length=12)
    newname= models.CharField(max_length=2)

class Filedownload(models.Model):
    pass