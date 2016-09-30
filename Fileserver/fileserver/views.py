from rest_framework.views import APIView
from rest_framework import status
from rest_framework.response import Response
from rest_framework.authentication import SessionAuthentication, BasicAuthentication
from rest_framework.permissions import IsAuthenticated
from rest_framework.parsers import FileUploadParser, MultiPartParser
from django.http import HttpResponse
from django.template import loader
from django.conf import settings
from django.views.static import serve
from fileserver.authentications import CsrfExemptSessionAuthentication
from fileserver.serializers import FileSerializer
import os

#class based views inherited from APIView

class Homepage(APIView):
    """
    View for homepage
    """
    def get(self, request):
        template = loader.get_template('index.html')
        return HttpResponse(template.render(request))


class UploadFile(APIView):
    """
    View to upload file for a user.

    """
    # Use basic authentication to ensure logged in users upload file
    authentication_classes = (CsrfExemptSessionAuthentication, BasicAuthentication)
    permission_classes = (IsAuthenticated,)
    # Parser class to read file
    parser_classes = (MultiPartParser, )

    def put(self, request, format=None):
        """
        Return 200 if file is saved successfully
        """
        file = request.FILES['file']

        # Check if file is greater than max upload size
        if file._size > settings.MAX_UPLOAD_SIZE:
            return Response("File too large", status=status.HTTP_400_BAD_REQUEST)

        # Add the user information to our serializer
        request.data['user'] = request.user.id
        serializer = FileSerializer(data=request.data)

        if serializer.is_valid():
           serializer.save()
           return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(status=status.HTTP_400_BAD_REQUEST)

class DownloadFile(APIView):
    """
    View to download file for a user.

    """
    authentication_classes = (CsrfExemptSessionAuthentication, BasicAuthentication)
    permission_classes = (IsAuthenticated,)

    def get(self, request, pk, format=None):
        """
        Return 200 with file
        """
        # Ensure that the file belongs to logged on user
        if int(pk) == request.user.id:
            user = request.user
            # get file path and serve to user
            path = os.getcwd() + request.get_full_path()
            return serve(request, os.path.basename(path), os.path.dirname(path))

        return Response(status=status.HTTP_404_NOT_FOUND)