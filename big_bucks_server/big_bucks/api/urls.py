from django.urls import path
from . import views

urlpatterns = [
    path("expenses", views.expenses),
    path("expenses/<int:expense_id>", views.expenses_detail),
]
