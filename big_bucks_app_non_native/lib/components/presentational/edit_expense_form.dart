import 'package:big_bucks_app/model/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditExpenseForm extends StatelessWidget {
  final Expense _expense;

  const EditExpenseForm({
    super.key,
    required Expense expense,
  }) : _expense = expense;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  initialValue: _expense.name,
                  decoration: const InputDecoration(
                    hintText: "Expense name:",
                  ),
                ),
              ],
            ),
          ),
          Container(
            constraints: const BoxConstraints.tightFor(
              height: 60,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const <Widget>[
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: null,
                    child: Text("Cancel"),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: null,
                    child: Text("Apply"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
