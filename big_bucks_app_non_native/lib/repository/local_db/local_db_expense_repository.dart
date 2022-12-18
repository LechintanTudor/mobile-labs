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

  Future<void> setUpDatabase() async {
    await _database.execute('''
      CREATE TABLE IF NOT EXISTS $expenseTable (
        $idColumn INTEGER PRIMARY KEY NOT NULL,
        $nameColumn CHAR(64) NOT NULL,
        $valueColumn INTEGER NOT NULL,
        $recurrenceColumn CHAR(64) NOT NULL,
        $startDateColumn CHAR(16) NOT NULL,
        $endDateColumn CHAR(16)
      );
    ''');
  }

  @override
  Future<Expense> add(Expense expense) async {
    if (expense.id != 0) {
      throw AddExpenseError();
    }

    var expenseObject = _expenseToDbObject(expense)..remove(idColumn);
    var expenseId = await _database.insert(expenseTable, expenseObject);
    return expense.copyWith(id: expenseId);
  }

  @override
  Future<Expense?> getById(int expenseId) async {
    var expenseObjects = await _database.query(
      expenseTable,
      columns: allColumns,
      where: 'id = ?',
      whereArgs: [expenseId],
    );

    return expenseObjects.isNotEmpty
        ? _expenseFromDbObject(expenseObjects[0])
        : null;
  }

  @override
  Future<List<Expense>> getAll() async {
    var expenseObjects = await _database.query(
      expenseTable,
      columns: allColumns,
    );

    return expenseObjects.map(_expenseFromDbObject).toList(growable: false);
  }

  @override
  Future<bool> update(Expense expense) async {
    var updated = await _database.update(
      expenseTable,
      _expenseToDbObject(expense),
      where: 'id = ?',
      whereArgs: [expense.id],
    );

    return updated > 0;
  }

  @override
  Future<void> deleteAll() async {
    await _database.delete(expenseTable);
  }

  @override
  Future<bool> deleteById(int expenseId) async {
    var deleted = await _database.delete(
      expenseTable,
      where: 'id = ?',
      whereArgs: [expenseId],
    );

    return deleted > 0;
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
