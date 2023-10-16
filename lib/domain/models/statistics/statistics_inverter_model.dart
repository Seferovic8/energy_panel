// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
class StatisticsInverterModel {
  final double power;
  final double energy;
  StatisticsInverterModel({
    required this.power,
    required this.energy,
  });

  StatisticsInverterModel copyWith({
    double? power,
    double? energy,
  }) {
    return StatisticsInverterModel(
      power: power ?? this.power,
      energy: energy ?? this.energy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'power': power,
      'energy': energy,
    };
  }

  factory StatisticsInverterModel.fromMap(Map<String, dynamic> map) {
    return StatisticsInverterModel(
      power: map['power'] as double,
      energy: map['energy'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory StatisticsInverterModel.fromJson(String source) => StatisticsInverterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StatisticsInverterModel(power: $power, energy: $energy)';
  }
}
