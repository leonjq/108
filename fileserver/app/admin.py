from django.contrib import admin
#from fileserver.models import Fileupload
#from fileserver.models import encode
#from fileserver.models import Filedownload
from app.models import Fileupload
from app.models import encode
from app.models import Filedownload


# Register your models here.
admin.site.register(Fileupload)
admin.site.register(encode)
admin.site.register(Filedownload)


