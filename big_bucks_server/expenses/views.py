from django.http.response import JsonResponse, HttpResponse
from rest_framework import status
from rest_framework.parsers import JSONParser
from rest_framework.permissions import IsAuthenticated
from rest_framework.views import APIView

from expenses.models import Expense
from expenses.serializers import ExpenseSerializer


class ExpenseView(APIView):
    permission_classes = (IsAuthenticated,)

    def get(self, request):
        expense_list = Expense.objects.filter(user_id=request.user)
        expense_serializer = ExpenseSerializer(expense_list, many=True)
        return JsonResponse(expense_serializer.data, safe=False)

    def post(self, request):
        expense_data = JSONParser().parse(request)
        expense_serializer = ExpenseSerializer(data=expense_data)

        if not expense_serializer.is_valid():
            return JsonResponse(
                expense_serializer.errors,
                status=status.HTTP_400_BAD_REQUEST,
            )

        expense_serializer.save(user_id=request.user)
        return JsonResponse(expense_serializer.data, status=status.HTTP_201_CREATED)

    def delete(self, request):
        Expense.objects.filter(user_id=request.user).delete()
        return HttpResponse(status=status.HTTP_204_NO_CONTENT)


class ExpenseDetailView(APIView):
    permission_classes = (IsAuthenticated,)

    def find_expense(self, request, expense_id):
        try:
            return Expense.objects.get(id=expense_id, user_id=request.user)
        except Expense.DoesNotExist:
            return None

    def get(self, request, expense_id):
        expense = self.find_expense(request, expense_id)

        if expense is None:
            return HttpResponse(status=status.HTTP_404_NOT_FOUND)

        expense_serializer = ExpenseSerializer(expense)
        return JsonResponse(expense_serializer.data)

    def put(self, request, expense_id):
        expense = self.find_expense(request, expense_id)

        if expense is None:
            return HttpResponse(status=status.HTTP_404_NOT_FOUND)
            
        expense_data = JSONParser().parse(request)
        expense_serializer = ExpenseSerializer(expense, data=expense_data)

        if not expense_serializer.is_valid():
            return JsonResponse(
                expense_serializer.errors,
                status=status.HTTP_400_BAD_REQUEST,
            )

        expense_serializer.save()
        return JsonResponse(expense_serializer.data, status=status.HTTP_201_CREATED)

    def delete(self, request, expense_id):
        expense = self.find_expense(request, expense_id)

        if expense is None:
            return HttpResponse(status=status.HTTP_404_NOT_FOUND)

        expense.delete()
        return HttpResponse(status=status.HTTP_204_NO_CONTENT)
