// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SmaModel {
  final double power;
  final double voltage;
  final double current;
  final double consumption;
  SmaModel({
    required this.power,
    required this.voltage,
    required this.current,
    required this.consumption,
  });

  SmaModel copyWith({
    double? power,
    double? voltage,
    double? current,
    double? consumption,
  }) {
    return SmaModel(
      power: power ?? this.power,
      voltage: voltage ?? this.voltage,
      current: current ?? this.current,
      consumption: consumption ?? this.consumption,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'power': power,
      'voltage': voltage,
      'current': current,
      'consumption': consumption,
    };
  }

  factory SmaModel.fromMap(Map<String, dynamic> map) {
    return SmaModel(
      power: map['power'] as double,
      voltage: map['voltage'] as double,
      current: map['current'] as double,
      consumption: map['consumption'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory SmaModel.fromJson(String source) => SmaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SmaModel(power: $power, voltage: $voltage, current: $current, consumption: $consumption)';
  }
}
