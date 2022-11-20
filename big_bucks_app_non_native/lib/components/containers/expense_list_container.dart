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
        return ExpenseList(
          expenses: state.expenses,
          selectedExpenseId: state.selectedExpenseId,
          onCardPressed: (expenseId) {
            var expensesCubit = context.read<ExpensesCubit>();
            expensesCubit.toggleSelectExpenseById(expenseId);
          },
        );
      },
    );
  }
}
