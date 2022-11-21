import 'package:big_bucks_app/components/containers/edit_expense_form_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditExpensePage extends StatelessWidget {
  const EditExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("BIG BUCK\$"),
      ),
      body: const EditExpenseFormContainer(),
    );
  }
}
