// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:energy_panel/_all.dart';

class StatisticsModel {
  final DateTime date;
  final StatisticsSmaModel sma;
  final StatisticsInverterModel inverter;
  final double consumptionPower;
  final double consumption;
  StatisticsModel({
    required this.date,
    required this.sma,
    required this.inverter,
    required this.consumptionPower,
    required this.consumption,
  });

  StatisticsModel copyWith({
    DateTime? date,
    StatisticsSmaModel? sma,
    StatisticsInverterModel? inverter,
    double? consumptionPower,
    double? consumption,
  }) {
    return StatisticsModel(
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

  factory StatisticsModel.fromMap(Map<String, dynamic> map) {
    return StatisticsModel(
      date: HttpDate.parse(map['date']),
      sma: StatisticsSmaModel.fromMap(map['sma'] as Map<String, dynamic>),
      inverter: StatisticsInverterModel.fromMap(map['inverter'] as Map<String, dynamic>),
      consumptionPower: map['consumption_power'] as double,
      consumption: map['consumption'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory StatisticsModel.fromJson(String source) => StatisticsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StatisticsModel(date: $date, sma: $sma, inverter: $inverter, consumption_power: $consumptionPower, consumption: $consumption)';
  }
}