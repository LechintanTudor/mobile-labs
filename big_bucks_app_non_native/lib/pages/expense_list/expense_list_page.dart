import 'package:big_bucks_app/components/expense_card.dart';
import 'package:big_bucks_app/global/cubit/auth_cubit.dart';
import 'package:big_bucks_app/pages/add_expense/add_expense_page.dart';
import 'package:big_bucks_app/pages/edit_expense/edit_expense_page.dart';
import 'package:big_bucks_app/pages/expense_list/cubit/expense_list_cubit.dart';
import 'package:big_bucks_app/pages/expense_list/cubit/expense_list_state.dart';
import 'package:big_bucks_app/pages/log_in/log_in_page.dart';
import 'package:big_bucks_app/repository/abstract/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseListPage extends StatelessWidget {
  const ExpenseListPage({super.key});

  static Route route({
    required ExpenseRepository expenseRepository,
    required bool isOnline,
  }) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) {
          return ExpenseListCubit(
            expenseRepository: expenseRepository,
            isOnline: isOnline,
          )..getAllExpenses();
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
            actions: [
              TextButton(
                onPressed: () {},
                child: IconButton(
                  icon: const Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Log Out?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                if (state.isOnline) {
                                  context.read<AuthCubit>().logOut();
                                }

                                Navigator.pushAndRemoveUntil(
                                  context,
                                  LogInPage.route(),
                                  (route) => false,
                                );
                              },
                              child: const Text('YES'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('NO'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              )
            ],
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
                  onEditPressed: () {
                    Navigator.push(
                      context,
                      EditExpensePage.route(
                        expenseListCubit: expenseListCubit,
                        expense: expense,
                      ),
                    );
                  },
                  onDeletePressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Delete Expense?'),
                          content: const Text(
                              'Are you sure you want to delete this expense?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                expenseListCubit.deleteExpenseById(expense.id);
                                Navigator.pop(context);
                              },
                              child: const Text('DELETE'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('CANCEL'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  expanded: expense.id == state.selectedExpenseId,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 8);
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                AddExpensePage.route(expenseListCubit: expenseListCubit),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
