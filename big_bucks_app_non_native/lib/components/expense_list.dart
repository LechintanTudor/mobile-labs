import 'package:big_bucks_app/components/expense_card.dart';
import 'package:big_bucks_app/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> _expenses;

  const ExpenseList({super.key, required List<Expense> expenses})
      : _expenses = expenses;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        itemCount: _expenses.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ExpenseCard(expense: _expenses[index]),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 8,
          );
        },
      ),
    );
  }
}
