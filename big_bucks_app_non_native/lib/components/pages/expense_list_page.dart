import 'package:big_bucks_app/components/containers/expense_list_container.dart';
import 'package:big_bucks_app/components/pages/add_expense_page.dart';
import 'package:flutter/material.dart';

class ExpenseListPage extends StatelessWidget {
  const ExpenseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("BIG BUCK\$"),
      ),
      body: const ExpenseListContainer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        elevation: 10,
        onPressed: () {
          Navigator.push(context, AddExpensePage.route());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
