import 'package:big_bucks_app/model/expense.dart';
import 'package:big_bucks_app/model/recurrence.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseCard extends StatelessWidget {
  final Expense _expense;

  const ExpenseCard({super.key, required Expense expense}) : _expense = expense;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.tightFor(
        height: 160,
      ),
      decoration: const BoxDecoration(
        color: Colors.green,
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _expense.name,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  recurrenceDisplayString(_expense),
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.lightGreen,
              ),
              child: Center(
                child: Text(
                  "\$${_expense.value}",
                  style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

String recurrenceDisplayString(Expense expense) {
  switch (expense.recurrence) {
    case Recurrence.oneTime:
      return DateFormat("yyyy-MM-dd").format(expense.startDate);

    case Recurrence.daily:
      return "daily";

    case Recurrence.weeky:
      return "weekly";

    case Recurrence.monthly:
      return "monthly";
  }
}
