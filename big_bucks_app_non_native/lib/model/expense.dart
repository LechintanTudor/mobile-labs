import 'package:big_bucks_app/model/recurrence.dart';

class Expense {
  final int id;
  final String name;
  final int value;
  final Recurrence recurrence;
  final DateTime startDate;
  final DateTime? endDate;

  Expense({
    this.id = 0,
    required this.name,
    required this.value,
    required this.recurrence,
    required this.startDate,
    this.endDate,
  });

  Expense copyWith({
    int? id,
    String? name,
    int? value,
    Recurrence? recurrence,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return Expense(
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
      recurrence: recurrence ?? this.recurrence,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
