import 'package:big_bucks_app/blocs/expense_list/expense_list_cubit.dart';
import 'package:big_bucks_app/components/pages/log_in_page.dart';
import 'package:big_bucks_app/repository/abstract/expense_repository.dart';
import 'package:big_bucks_app/repository/local_db/local_db_expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var databasePath = path.join(await getDatabasesPath(), 'big_bucks_new.db');
  var database = await openDatabase(databasePath);
  var expenseRepository = LocalDbExpenseRepository(database: database);
  await expenseRepository.setUpDatabase();

  runApp(BigBucksApp(expenseRepository: expenseRepository));
}

class BigBucksApp extends StatelessWidget {
  final ExpenseRepository _expenseRepository;

  const BigBucksApp({
    super.key,
    required ExpenseRepository expenseRepository,
  }) : _expenseRepository = expenseRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ExpenseListCubit(_expenseRepository)..getAllExpenses();
      },
      child: const MaterialApp(
        title: 'BIG BUCK\$',
        home: LogInPage(),
      ),
    );
  }
}
