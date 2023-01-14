import 'package:big_bucks_app/global/formats.dart';
import 'package:big_bucks_app/model/recurrence.dart';
import 'package:equatable/equatable.dart';

class Expense extends Equatable {
  final int id;
  final String name;
  final int value;
  final Recurrence recurrence;
  final DateTime startDate;
  final DateTime? endDate;

  const Expense({
    this.id = 0,
    required this.name,
    required this.value,
    required this.recurrence,
    required this.startDate,
    this.endDate,
  });

  Expense.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        value = json['value'],
        recurrence = Recurrence.fromShortString(json['recurrence']),
        startDate = globalDateFormat.parse(json['start_date']),
        endDate = json['end_date'] != null
            ? globalDateFormat.parse(json['end_date'])
            : null;

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

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'value': value,
        'recurrence': recurrence.toShortString(),
        'start_date': globalDateFormat.format(startDate),
        'end_date': endDate != null ? globalDateFormat.format(endDate!) : null,
      };

  @override
  List<Object?> get props => [id, name, value, recurrence, startDate, endDate];
}
