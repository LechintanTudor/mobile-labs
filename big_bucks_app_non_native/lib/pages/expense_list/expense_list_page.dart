import 'package:big_bucks_app/components/expense_card.dart';
import 'package:big_bucks_app/pages/expense_list/cubit/expense_list_cubit.dart';
import 'package:big_bucks_app/pages/expense_list/cubit/expense_list_state.dart';
import 'package:big_bucks_app/repository/abstract/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseListPage extends StatelessWidget {
  const ExpenseListPage({super.key});

  static Route route({
    required ExpenseRepository expenseRepository,
  }) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) {
          return ExpenseListCubit(expenseRepository: expenseRepository)
            ..getAllExpenses();
        },
        child: const ExpenseListPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseListCubit, ExpenseListState>(
      builder: (context, state) {
        var expenseListCubit = context.read<ExpenseListCubit>();

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: const Text('Expenses'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.separated(
              itemCount: state.expenses.length,
              itemBuilder: (context, index) {
                var expense = state.expenses[index];

                return ExpenseCard(
                  expense: expense,
                  onCardPressed: () {
                    expenseListCubit.toggleSelectExpenseById(expense.id);
                  },
                  onEditPressed: () {},
                  onDeletePressed: () {},
                  expanded: expense.id == state.selectedExpenseId,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 8);
              },
            ),
          ),
        );
      },
    );
  }
}
