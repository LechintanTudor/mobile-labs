import 'dart:convert';
import 'package:big_bucks_app/global/urls.dart';
import 'package:big_bucks_app/model/expense.dart';
import 'package:big_bucks_app/repository/abstract/expense_repository.dart';
import 'package:http/http.dart' as http;

class HttpExpenseRepository extends ExpenseRepository {
  final String _token;

  const HttpExpenseRepository({required String token}) : _token = token;

  @override
  Future<Expense> add(Expense expense) async {
    var response = await http.post(
      Uri.http(globalApiAuthority, '/expenses/'),
      headers: getCommonHeaders(),
      body: jsonEncode(expense.toJson()),
    );

    if (response.statusCode != 201) {
      throw const ExpenseError('failed to add expense');
    }

    return Expense.fromJson(jsonDecode(response.body));
  }

  @override
  Future<Expense?> getById(int expenseId) async {
    var response = await http.get(
      Uri.http(globalApiAuthority, '/expenses/$expenseId'),
      headers: getCommonHeaders(),
    );

    if (response.statusCode != 200) {
      return null;
    }

    return Expense.fromJson(jsonDecode(response.body));
  }

  @override
  Future<List<Expense>> getAll() async {
    var respose = await http.get(
      Uri.http(globalApiAuthority, '/expenses/'),
      headers: getCommonHeaders(),
    );

    if (respose.statusCode != 200) {
      throw const ExpenseError('failed to get expenses');
    }

    return (jsonDecode(respose.body) as List)
        .map((expense) => Expense.fromJson(expense))
        .toList();
  }

  @override
  Future<bool> update(Expense expense) async {
    var response = await http.put(
      Uri.http(globalApiAuthority, '/expenses/${expense.id}'),
      headers: getCommonHeaders(),
      body: jsonEncode(expense.toJson()),
    );

    if (response.statusCode != 201) {
      throw const ExpenseError('failed to update expense');
    }

    return true;
  }

  @override
  Future<bool> deleteById(int expenseId) async {
    var response = await http.delete(
      Uri.http(globalApiAuthority, '/expenses/$expenseId'),
      headers: getCommonHeaders(),
    );

    switch (response.statusCode) {
      case 204:
        return true;

      case 404:
        return false;

      default:
        throw const ExpenseError('failed to delete expense');
    }
  }

  @override
  Future<void> deleteAll() async {
    var response = await http.delete(
      Uri.http(globalApiAuthority, '/expenses/'),
      headers: getCommonHeaders(),
    );

    if (response.statusCode != 204) {
      throw const ExpenseError('failed to delete all expenses');
    }
  }

  Map<String, String> getCommonHeaders() {
    return {
      'Authorization': 'Token $_token',
      'Content-Type': 'application/json',
    };
  }
}
