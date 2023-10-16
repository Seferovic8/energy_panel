// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StatisticsSmaModel {
  final double power;
  final double consumption;
  StatisticsSmaModel({
    required this.power,
    required this.consumption,
  });

  StatisticsSmaModel copyWith({
    double? power,
    double? consumption,
  }) {
    return StatisticsSmaModel(
      power: power ?? this.power,
      consumption: consumption ?? this.consumption,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'power': power,
      'consumption': consumption,
    };
  }

  factory StatisticsSmaModel.fromMap(Map<String, dynamic> map) {
    return StatisticsSmaModel(
      power: map['power'] as double,
      consumption: map['consumption'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory StatisticsSmaModel.fromJson(String source) => StatisticsSmaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StatisticsSmaModel(power: $power, consumption: $consumption)';
  }
}
