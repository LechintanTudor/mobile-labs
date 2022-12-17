import 'package:big_bucks_app/blocs/expense_list/expense_list_cubit.dart';
import 'package:big_bucks_app/blocs/expense_list/expense_list_state.dart';
import 'package:big_bucks_app/components/presentational/expense_form.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditExpenseFormContainer extends StatelessWidget {
  const EditExpenseFormContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseListCubit, ExpenseListState>(
      builder: (context, state) {
        return ExpenseForm(
          expense: state.findSelectedExpense(),
          onApplyPressed: (expense) {
            context.read<ExpenseListCubit>().updateExpense(expense);
            Navigator.pop(context);
          },
          onCancelPressed: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
