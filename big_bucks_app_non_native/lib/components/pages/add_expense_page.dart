import 'package:big_bucks_app/components/containers/add_expense_form_container.dart';
import 'package:flutter/material.dart';

class AddExpensePage extends StatelessWidget {
  const AddExpensePage({super.key});

  static Route route() {
    return MaterialPageRoute(builder: (context) => const AddExpensePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("BIG BUCK\$"),
      ),
      body: const AddExpenseFormContainer(),
    );
  }
}
