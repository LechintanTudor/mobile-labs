import 'package:big_bucks_app/repository/abstract/expense_repository.dart';
import 'package:big_bucks_app/model/expense.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

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

  final Database _database;

  LocalDbExpenseRepository({required Database database}) : _database = database;

  static Future<LocalDbExpenseRepository> create() async {
    var databasePath = path.join(await getDatabasesPath(), 'big_bucks_new.db');
    var database = await openDatabase(databasePath);

    var expenseRepository = LocalDbExpenseRepository(database: database);
    await expenseRepository.setUpDatabase();
    return expenseRepository;
  }

  Future<void> setUpDatabase() async {
    await _database.execute('''
      CREATE TABLE IF NOT EXISTS $expenseTable (
        $idColumn INTEGER PRIMARY KEY NOT NULL,
        $nameColumn CHAR(64) NOT NULL,
        $valueColumn INTEGER NOT NULL,
        $recurrenceColumn CHAR(1) NOT NULL,
        $startDateColumn CHAR(16) NOT NULL,
        $endDateColumn CHAR(16)
      );
    ''');
  }

  @override
  Future<Expense> add(Expense expense) async {
    if (expense.id != 0) {
      throw const ExpenseError('failed to add expense');
    }

    var expenseObject = expense.toJson()..remove(idColumn);
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
        ? Expense.fromJson(expenseObjects[0])
        : null;
  }

  @override
  Future<List<Expense>> getAll() async {
    var expenseObjects = await _database.query(
      expenseTable,
      columns: allColumns,
    );

    return expenseObjects.map(Expense.fromJson).toList(growable: false);
  }

  @override
  Future<bool> update(Expense expense) async {
    var updated = await _database.update(
      expenseTable,
      expense.toJson(),
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
}
