import 'package:big_bucks_app/repository/abstract/expense_repository.dart';

class LogInState {
  final ExpenseRepository? expenseRepository;
  final bool isOnline;
  final String error;

  const LogInState({
    this.expenseRepository,
    this.isOnline = false,
    this.error = '',
  });
}
