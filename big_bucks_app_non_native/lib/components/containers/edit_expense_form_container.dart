import 'package:big_bucks_app/blocs/expense_list/expenses_cubit.dart';
import 'package:big_bucks_app/blocs/expense_list/expenses_state.dart';
import 'package:big_bucks_app/components/presentational/edit_expense_form.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditExpenseFormContainer extends StatelessWidget {
  const EditExpenseFormContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseListCubit, ExpenseListState>(
      builder: (context, state) {
        return EditExpenseForm(
          expense: state.findSelectedExpense(),
          onApplyPressed: (expense) {
            Navigator.pop(context);
            context.read<ExpenseListCubit>().updateExpense(expense);
          },
          onCancelPressed: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
