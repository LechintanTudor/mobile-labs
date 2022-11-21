import 'package:big_bucks_app/blocs/expense_list/expenses_cubit.dart';
import 'package:big_bucks_app/components/presentational/expense_form.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpenseFormContainer extends StatelessWidget {
  const AddExpenseFormContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpenseForm(
      onApplyPressed: (expense) {
        context.read<ExpenseListCubit>().addExpense(expense);
        Navigator.pop(context);
      },
      onCancelPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
