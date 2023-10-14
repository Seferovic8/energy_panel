// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:energy_panel/_all.dart';

class RealtimeModel {
  final DateTime date;
  final SmaModel sma;
  final InverterModel inverter;
  final double consumptionPower;
  final double consumption;
  RealtimeModel({
    required this.date,
    required this.sma,
    required this.inverter,
    required this.consumptionPower,
    required this.consumption,
  });

  RealtimeModel copyWith({
    DateTime? date,
    SmaModel? sma,
    InverterModel? inverter,
    double? consumptionPower,
    double? consumption,
  }) {
    return RealtimeModel(
      date: date ?? this.date,
      sma: sma ?? this.sma,
      inverter: inverter ?? this.inverter,
      consumptionPower: consumptionPower ?? this.consumptionPower,
      consumption: consumption ?? this.consumption,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.millisecondsSinceEpoch,
      'sma': sma.toMap(),
      'inverter': inverter.toMap(),
      'consumption_power': consumptionPower,
      'consumption': consumption,
    };
  }

  factory RealtimeModel.fromMap(Map<String, dynamic> map) {
    return RealtimeModel(
      date: HttpDate.parse(map['date']),
      sma: SmaModel.fromMap(map['sma'] as Map<String, dynamic>),
      inverter: InverterModel.fromMap(map['inverter'] as Map<String, dynamic>),
      consumptionPower: map['consumption_power'] as double,
      consumption: map['consumption'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory RealtimeModel.fromJson(String source) => RealtimeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RealtimeModel(date: $date, sma: $sma, inverter: $inverter, consumption_power: $consumptionPower, consumption: $consumption)';
  }
}
