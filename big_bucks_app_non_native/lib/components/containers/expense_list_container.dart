import 'package:big_bucks_app/blocs/expenses/expenses_cubit.dart';
import 'package:big_bucks_app/blocs/expenses/expenses_state.dart';
import 'package:big_bucks_app/components/presentational/expense_list.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseListContainer extends StatelessWidget {
  const ExpenseListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpensesCubit, ExpensesState>(
      builder: (context, state) {
        var expensesCubit = context.read<ExpensesCubit>();

        return ExpenseList(
          expenses: state.expenses,
          selectedExpenseId: state.selectedExpenseId,
          onCardPressed: (expenseId) {
            expensesCubit.toggleSelectExpenseById(expenseId);
          },
          onEditPressed: (expenseId) {
            expensesCubit.selectExpenseById(expenseId);
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
