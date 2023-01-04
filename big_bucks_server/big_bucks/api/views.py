from django.http.response import JsonResponse, HttpResponse
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.parsers import JSONParser

from api.models import Expense
from api.serializers import ExpenseSerializer


@api_view(["GET", "POST", "DELETE"])
def expenses(request):
    if request.method == "GET":
        expense_list = Expense.objects.all()
        expense_serializer = ExpenseSerializer(expense_list, many=True)
        return JsonResponse(expense_serializer.data, safe=False)

    elif request.method == "POST":
        expense_data = JSONParser().parse(request)
        expense_serializer = ExpenseSerializer(data=expense_data)

        if not expense_serializer.is_valid():
            return JsonResponse(
                expense_serializer.errors,
                status=status.HTTP_400_BAD_REQUEST,
            )

        expense_serializer.save()
        return JsonResponse(expense_serializer.data, status=status.HTTP_201_CREATED)

    elif request.method == "DELETE":
        Expense.objects.all().delete()
        return HttpResponse(status=status.HTTP_204_NO_CONTENT)


@api_view(["GET", "PUT", "DELETE"])
def expenses_detail(request, expense_id):
    try:
        expense = Expense.objects.get(id=expense_id)
    except Expense.DoesNotExist:
        return JsonResponse(
            {message: "Expense does not exist"},
            status=status.HTTP_404_NOT_FOUND,
        )

    if request.method == "GET":
        expense_serializer = ExpenseSerializer(expense)
        return JsonResponse(expense_serializer.data)

    elif request.method == "PUT":
        expense_data = JSONParser().parse(request)
        expense_serializer = ExpenseSerializer(expense, data=expense_data)

        if not expense_serializer.is_valid():
            return JsonResponse(
                expense_serializer.errors,
                status=status.HTTP_400_BAD_REQUEST,
            )

        expense_serializer.save()
        return JsonResponse(expense_serializer.data, status=status.HTTP_201_CREATED)

    elif request.method == "DELETE":
        expense.delete()
        return HttpResponse(status=status.HTTP_204_NO_CONTENT)
