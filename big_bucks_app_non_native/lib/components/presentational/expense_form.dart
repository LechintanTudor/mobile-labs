import 'package:big_bucks_app/global/formats.dart';
import 'package:big_bucks_app/model/expense.dart';
import 'package:big_bucks_app/model/recurrence.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ExpenseForm extends StatefulWidget {
  final Expense? _expense;
  final void Function(Expense expense) _onApplyPressed;
  final void Function() _onCancelPressed;

  const ExpenseForm({
    super.key,
    Expense? expense,
    required void Function(Expense expense) onApplyPressed,
    required void Function() onCancelPressed,
  })  : _expense = expense,
        _onApplyPressed = onApplyPressed,
        _onCancelPressed = onCancelPressed;

  @override
  ExpenseFormState createState() => ExpenseFormState();
}

class ExpenseFormState extends State<ExpenseForm> {
  late String _name;
  late String _valueStr;
  late Recurrence _recurrence;
  late String _startDateStr;

  @override
  void initState() {
    super.initState();

    var expense = widget._expense;
    _name = expense?.name ?? '';
    _valueStr = expense?.value.toString() ?? '0';
    _recurrence = expense?.recurrence ?? Recurrence.oneTime;
    _startDateStr =
        globalDateFormat.format(expense?.startDate ?? DateTime.now());
  }

  Expense? _getExpense() {
    var name = _name.trim();

    if (name.isEmpty) {
      return null;
    }

    try {
      var value = int.parse(_valueStr);

      if (value <= 0) {
        return null;
      }

      var startDate = DateFormat('yyyy-MM-dd').parse(_startDateStr);

      return Expense(
        id: widget._expense?.id ?? 0,
        name: name,
        value: value,
        recurrence: _recurrence,
        startDate: startDate,
      );
    } catch (error) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var expense = _getExpense();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  onChanged: (name) => setState(() {
                    _name = name;
                  }),
                  initialValue: _name,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                TextFormField(
                  onChanged: (valueStr) => setState(() {
                    _valueStr = valueStr;
                  }),
                  initialValue: _valueStr,
                  decoration: const InputDecoration(
                    labelText: 'Value',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                DropdownButtonFormField(
                  onChanged: (recurrence) => setState(() {
                    if (recurrence != null) {
                      _recurrence = recurrence;
                    }
                  }),
                  value: _recurrence,
                  items: const <DropdownMenuItem<Recurrence>>[
                    DropdownMenuItem(
                      value: Recurrence.oneTime,
                      child: Text('one time'),
                    ),
                    DropdownMenuItem(
                      value: Recurrence.daily,
                      child: Text('daily'),
                    ),
                    DropdownMenuItem(
                      value: Recurrence.weeky,
                      child: Text('weekly'),
                    ),
                    DropdownMenuItem(
                      value: Recurrence.monthly,
                      child: Text('monhtly'),
                    ),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Recurrence',
                  ),
                ),
                TextFormField(
                  onChanged: (startDateStr) => setState(() {
                    _startDateStr = startDateStr;
                  }),
                  initialValue: _startDateStr,
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(
                    labelText: 'Start date (yyyy-MM-dd)',
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
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: widget._onCancelPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 171, 46, 24),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      if (expense != null) {
                        widget._onApplyPressed(expense);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 25, 159, 25),
                    ),
                    child: const Text('Apply'),
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
