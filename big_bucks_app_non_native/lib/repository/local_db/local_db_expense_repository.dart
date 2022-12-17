import 'package:big_bucks_app/model/recurrence.dart';
import 'package:big_bucks_app/repository/abstract/expense_repository.dart';
import 'package:big_bucks_app/model/expense.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class LocalDbExpenseRepository extends ExpenseRepository {
  static const expenseTable = 'expense';
  static const idColumn = 'id';
  static const nameColumn = 'name';
  static const valueColumn = 'value';
  static const recurrenceColumn = 'recurrence';
  static const startDateColumn = 'start_date';
  static const endDateColumn = 'end_date';

  static const allColumns = [
    idColumn,
    nameColumn,
    valueColumn,
    recurrenceColumn,
    startDateColumn,
    endDateColumn,
  ];

  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  final Database _database;

  LocalDbExpenseRepository({required Database database}) : _database = database;

  @override
  Future<Expense> add(Expense expense) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAll() async {
    // TODO: implement deleteAll
  }

  @override
  Future<bool> deleteById(int expenseId) {
    // TODO: implement deleteById
    throw UnimplementedError();
  }

  @override
  Future<List<Expense>> getAll() {
    _database.query(expenseTable, columns: allColumns);

    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Expense?> getById(int expenseId) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Expense expense) {
    // TODO: implement update
    throw UnimplementedError();
  }

  Recurrence _recurrenceFromDbString(String recurrence) {
    switch (recurrence) {
      case 'one_time':
        return Recurrence.oneTime;

      case 'daily':
        return Recurrence.daily;

      case 'weekly':
        return Recurrence.weeky;

      case 'monthly':
        return Recurrence.monthly;

      default:
        throw ArgumentError('Invalid recurrence string', recurrence);
    }
  }

  String _recurrenceToDbString(Recurrence recurrence) {
    switch (recurrence) {
      case Recurrence.oneTime:
        return 'one_time';

      case Recurrence.daily:
        return 'daily';

      case Recurrence.weeky:
        return 'weekly';

      case Recurrence.monthly:
        return 'monthly';
    }
  }

  Map<String, Object?> _expenseToDbObject(Expense expense) {
    return {
      idColumn: expense.id,
      nameColumn: expense.name,
      valueColumn: expense.value,
      recurrenceColumn: _recurrenceToDbString(expense.recurrence),
      startDateColumn: _dateFormat.format(expense.startDate),
      endDateColumn:
          expense.endDate != null ? _dateFormat.format(expense.endDate!) : null,
    };
  }

  Expense _expenseFromDbObject(Map<String, Object?> object) {
    return Expense(
      id: object[idColumn] as int,
      name: object[nameColumn] as String,
      value: object[valueColumn] as int,
      recurrence: _recurrenceFromDbString(object[recurrenceColumn] as String),
      startDate: _dateFormat.parse(object[startDateColumn] as String),
      endDate: object[endDateColumn] != null
          ? _dateFormat.parse(object[endDateColumn] as String)
          : null,
    );
  }
}
