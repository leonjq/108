from django.contrib import admin
from fileserver.models import Fileupload
from fileserver.models import encode
from fileserver.models import Filedownload

admin.site.register(Fileupload);
admin.site.register(encode)
admin.site.register(Filedownload)