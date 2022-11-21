import 'package:big_bucks_app/blocs/expense_list/expenses_cubit.dart';
import 'package:big_bucks_app/blocs/expense_list/expenses_state.dart';
import 'package:big_bucks_app/components/presentational/expense_list.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseListContainer extends StatelessWidget {
  const ExpenseListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseListCubit, ExpenseListState>(
      builder: (context, state) {
        var expenseListCubit = context.read<ExpenseListCubit>();

        return ExpenseList(
          expenses: state.expenses,
          selectedExpenseId: state.selectedExpenseId,
          onCardPressed: (expenseId) {
            expenseListCubit.toggleSelectExpenseById(expenseId);
          },
          onEditPressed: (expenseId) {
            expenseListCubit.selectExpenseById(expenseId);
            Navigator.pushNamed(context, '/edit-expense');
          },
          onDeletePressed: (expenseId) {
            debugPrint('Delete $expenseId');
          },
        );
      },
    );
  }
}
