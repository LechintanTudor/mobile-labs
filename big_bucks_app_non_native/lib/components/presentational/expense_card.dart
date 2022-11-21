import 'package:big_bucks_app/model/expense.dart';
import 'package:big_bucks_app/model/recurrence.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseCard extends StatelessWidget {
  final Expense _expense;
  final bool _expanded;
  final void Function()? _onCardPressed;
  final void Function()? _onEditPressed;
  final void Function()? _onDeletePressed;

  const ExpenseCard({
    super.key,
    required Expense expense,
    void Function()? onCardPressed,
    void Function()? onEditPressed,
    void Function()? onDeletePressed,
    bool expanded = false,
  })  : _expense = expense,
        _onCardPressed = onCardPressed,
        _onEditPressed = onEditPressed,
        _onDeletePressed = onDeletePressed,
        _expanded = expanded;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _onCardPressed,
          child: Container(
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
                      color: Colors.lightGreenAccent,
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
          ),
        ),
        if (_expanded)
          Container(
            constraints: const BoxConstraints.tightFor(
              height: 60,
            ),
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.lightGreenAccent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: _onEditPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 25, 159, 25),
                    ),
                    child: const Text("Edit"),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: _onDeletePressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 171, 46, 24),
                    ),
                    child: const Text("Delete"),
                  ),
                ),
              ],
            ),
          ),
      ],
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
