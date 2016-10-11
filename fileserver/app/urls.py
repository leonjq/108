from django.conf.urls import url
from django.conf.urls import include
from django.contrib import admin
from django.views.generic import RedirectView
from app.views import UploadFile
from app.views import DownloadFile
from app.views import Homepage

urlpatterns = [
    url(r'^admin/app/filedownload/$', RedirectView.as_view(url='http://172.16.1.24/')),
    url(r'^admin/app/encode/$', UploadFile.as_view()),
    url(r'^admin/', admin.site.urls),
    url(r'^upload/$', UploadFile.as_view()),
    url(r'^files/(?P<pk>[0-9]+)/.*$', DownloadFile.as_view()),
    url(r'^$', Homepage.as_view()),
]