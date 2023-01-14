from django.urls import path

from . import views

urlpatterns = [
    path("", views.ExpenseView.as_view()),
    path("<int:expense_id>", views.ExpenseDetailView.as_view()),
]
