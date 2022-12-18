import 'package:big_bucks_app/blocs/expense_list/expense_list_cubit.dart';
import 'package:big_bucks_app/blocs/expense_list/expense_list_state.dart';
import 'package:big_bucks_app/components/pages/edit_expense_page.dart';
import 'package:big_bucks_app/components/presentational/expense_list.dart';
import 'package:flutter/material.dart';
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
            Navigator.push(context, EditExpensePage.route());
          },
          onDeletePressed: (expenseId) => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Delete expense #$expenseId?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('CANCEL'),
                ),
                TextButton(
                  onPressed: () {
                    expenseListCubit.deleteExpenseById(expenseId);
                    Navigator.pop(context);
                  },
                  child: const Text('DELETE'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
