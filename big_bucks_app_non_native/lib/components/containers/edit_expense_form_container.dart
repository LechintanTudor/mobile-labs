import 'package:big_bucks_app/blocs/expenses/expenses_cubit.dart';
import 'package:big_bucks_app/blocs/expenses/expenses_state.dart';
import 'package:big_bucks_app/components/presentational/edit_expense_form.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditExpenseFormContainer extends StatelessWidget {
  const EditExpenseFormContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpensesCubit, ExpensesState>(
      builder: (context, state) {
        var expense = state.findSelectedExpense()!;
        return EditExpenseForm(expense: expense);
      },
    );
  }
}
