import 'dart:convert';

import 'package:equatable/equatable.dart';

class DateTimeValueObject extends Equatable {
  final bool isEnabled;
  final DateTime value;

  const DateTimeValueObject({required this.isEnabled, required this.value});
  @override
  List<Object?> get props => [isEnabled, value];

  factory DateTimeValueObject.empty() {
    return DateTimeValueObject(isEnabled: false, value: DateTime.now());
  }

  DateTimeValueObject copyWith({
    bool? isEnabled,
    DateTime? dateTime,
  }) {
    return DateTimeValueObject(
      isEnabled: isEnabled ?? this.isEnabled,
      value: dateTime ?? this.value,
    );
  }

  factory DateTimeValueObject.fromMap(Map<String, dynamic> map) {
    return DateTimeValueObject(
      isEnabled: map['isEnabled'],
      value: DateTime.parse(map['value']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isEnabled': isEnabled,
      'value': value.toIso8601String(),
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  factory DateTimeValueObject.fromJson(String json) {
    return DateTimeValueObject.fromMap(jsonDecode(json));
  }
}
