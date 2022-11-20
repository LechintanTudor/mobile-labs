import 'package:big_bucks_app/components/expense_list.dart';
import 'package:big_bucks_app/data/expense_repository.dart';
import 'package:big_bucks_app/model/expense.dart';
import 'package:big_bucks_app/model/recurrence.dart';
import 'package:flutter/material.dart';

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
    return MaterialApp(
      title: 'BIG BUCK\$',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('BIG BUCK\$'),
        ),
        body: ExpenseList(
          expenses: _expenseRepository.getAll(),
        ),
      ),
    );
  }
}
