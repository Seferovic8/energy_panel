// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
class InverterModel {
  final double power;
  final double voltage;
  final double current;
  final double energy;
  InverterModel({
    required this.power,
    required this.voltage,
    required this.current,
    required this.energy,
  });

  InverterModel copyWith({
    double? power,
    double? voltage,
    double? current,
    double? energy,
  }) {
    return InverterModel(
      power: power ?? this.power,
      voltage: voltage ?? this.voltage,
      current: current ?? this.current,
      energy: energy ?? this.energy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'power': power,
      'voltage': voltage,
      'current': current,
      'energy': energy,
    };
  }

  factory InverterModel.fromMap(Map<String, dynamic> map) {
    return InverterModel(
      power: map['power'] as double,
      voltage: map['voltage'] as double,
      current: map['current'] as double,
      energy: map['energy'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory InverterModel.fromJson(String source) => InverterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InverterModel(power: $power, voltage: $voltage, current: $current, energy: $energy)';
  }
}
