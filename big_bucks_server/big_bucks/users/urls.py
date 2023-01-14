from django.urls import path
from rest_framework.authtoken.views import obtain_auth_token

from .views import LogOutView, RegisterView

urlpatterns = [
    path("register", RegisterView.as_view()),
    path("login", obtain_auth_token),
    path("logout", LogOutView.as_view()),
]
