import 'package:big_bucks_app/components/expense_form.dart';
import 'package:big_bucks_app/model/expense.dart';
import 'package:big_bucks_app/pages/expense_list/cubit/expense_list_cubit.dart';
import 'package:big_bucks_app/pages/expense_list/cubit/expense_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditExpensePage extends StatelessWidget {
  final Expense _expense;

  const EditExpensePage({super.key, required Expense expense})
      : _expense = expense;

  static Route route({
    required ExpenseListCubit expenseListCubit,
    required Expense expense,
  }) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider.value(
          value: expenseListCubit..clearLastError(),
          child: EditExpensePage(expense: expense),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var expenseListCubit = context.read<ExpenseListCubit>();

    return BlocListener<ExpenseListCubit, ExpenseListState>(
      listener: (context, state) {
        if (state.error != '') {
          _showErrorDialog(context, error: state.error);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Edit Expense'),
        ),
        body: ExpenseForm(
          expense: _expense,
          onApplyPressed: (expense) {
            expenseListCubit.updateExpense(expense);
            Navigator.pop(context);
          },
          onCancelPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

void _showErrorDialog(
  BuildContext context, {
  required String error,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Error'),
      content: Text(error),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
