import 'package:big_bucks_app/components/expense_form.dart';
import 'package:big_bucks_app/pages/expense_list/cubit/expense_list_cubit.dart';
import 'package:big_bucks_app/pages/expense_list/cubit/expense_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpensePage extends StatelessWidget {
  const AddExpensePage({super.key});

  static Route route({
    required ExpenseListCubit expenseListCubit,
  }) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider.value(
          value: expenseListCubit..clearLastError(),
          child: const AddExpensePage(),
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
          title: const Text('Add Expense'),
        ),
        body: ExpenseForm(
          onApplyPressed: (expense) {
            expenseListCubit.addExpense(expense);
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

Widget _showErrorDialog(
  BuildContext context, {
  required String error,
}) {
  return AlertDialog(
    title: const Text('Error'),
    content: Text(error),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('OK'),
      ),
    ],
  );
}
