import 'package:big_bucks_app/blocs/expenses/expenses_cubit.dart';
import 'package:big_bucks_app/components/containers/expense_list_container.dart';
import 'package:big_bucks_app/components/pages/edit_expense_page.dart';
import 'package:big_bucks_app/components/pages/expense_list_page.dart';
import 'package:big_bucks_app/data/expense_repository.dart';
import 'package:big_bucks_app/model/expense.dart';
import 'package:big_bucks_app/model/recurrence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BigBucksApp());
}

class BigBucksApp extends StatelessWidget {
  final ExpenseRepository _expenseRepository = ExpenseRepository();

  BigBucksApp({super.key}) {
    _expenseRepository.add(Expense(
      name: "Electricity",
      value: 100,
      recurrence: Recurrence.monthly,
      startDate: DateTime.now(),
    ));
    _expenseRepository.add(Expense(
      name: "Rent",
      value: 800,
      recurrence: Recurrence.monthly,
      startDate: DateTime.now(),
    ));
    _expenseRepository.add(Expense(
      name: "Groceries",
      value: 300,
      recurrence: Recurrence.monthly,
      startDate: DateTime.now(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ExpensesCubit(_expenseRepository)..getAllExpenses();
      },
      child: MaterialApp(
        title: 'BIG BUCK\$',
        home: const ExpenseListPage(),
        routes: <String, WidgetBuilder>{
          '/edit-expense': (context) => const EditExpensePage(),
        },
      ),
    );
  }
}
