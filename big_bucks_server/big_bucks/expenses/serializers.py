from rest_framework.serializers import ModelSerializer
from expenses.models import Expense


class ExpenseSerializer(ModelSerializer):
    class Meta:
        model = Expense
        fields = (
            "id",
            "name",
            "value",
            "recurrence",
            "start_date",
            "end_date",
        )
