from django.contrib import admin
from django.urls import path, include
from api.views_health import health_check
from django.http import HttpResponse


def home(request):
    return HttpResponse("Savings UTL API is running 🚀")


urlpatterns = [
    path('', home, name='home'),   # homepage
    path('health/', health_check),
    path('admin/', admin.site.urls),
    path('api/', include('api.urls')),
]