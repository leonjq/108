from rest_framework.serializers import ModelSerializer
from fileserver.models import Fileupload

# middle man between model and view. ensure you need user and file to get and post file
class FileSerializer(ModelSerializer):
    class Meta:
        model = Fileupload
        fields = ('user', 'file', )
