// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart' as intl;

import 'package:energy_panel/_all.dart';

class Spots {
  final DateTime date;
  final double value;
  Spots({
    required this.date,
    required this.value,
  });

  Spots copyWith({
    DateTime? date,
    double? value,
  }) {
    return Spots(
      date: date ?? this.date,
      value: value ?? this.value,
    );
  }

  @override
  String toString() => 'Spots(date: $date, value: $value)';
}

class StatisticsModel {
  final DateTime startDate;
  final DateTime endDate;
  final double energy;
  final double consumption;
  final double smaPlus;
  final double smaMinus;
  final int chartType;
  final List<Spots> inverterFlSpots;
  final List<Spots> smaFlSpots;
  StatisticsModel({
    required this.startDate,
    required this.endDate,
    required this.energy,
    required this.consumption,
    required this.smaPlus,
    required this.smaMinus,
    required this.chartType,
    required this.inverterFlSpots,
    required this.smaFlSpots,
  });

  StatisticsModel copyWith({
    DateTime? startDate,
    DateTime? endDate,
    double? energy,
    double? consumption,
    double? smaPlus,
    double? smaMinus,
    int? chartType,
    List<Spots>? inverterFlSpots,
    List<Spots>? smaFlSpots,
  }) {
    return StatisticsModel(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      energy: energy ?? this.energy,
      consumption: consumption ?? this.consumption,
      smaPlus: smaPlus ?? this.smaPlus,
      smaMinus: smaMinus ?? this.smaMinus,
      chartType: chartType ?? this.chartType,
      inverterFlSpots: inverterFlSpots ?? this.inverterFlSpots,
      smaFlSpots: smaFlSpots ?? this.smaFlSpots,
    );
  }

  factory StatisticsModel.fromMap(Map<String, dynamic> map) {
    return StatisticsModel(
      startDate: HttpDate.parse(map['start_date']),
      endDate: HttpDate.parse(map['end_date']),
      energy: map['energy'] as double,
      consumption: map['consumption'] as double,
      smaPlus: map['sma_plus'] as double,
      smaMinus: map['sma_minus'] as double,
      chartType: map['chart_type'] as int,
      inverterFlSpots: (map['inverter_flspots'] as Map<dynamic, dynamic>).entries.map((e) => Spots(date: DateTime.parse(e.key), value: e.value)).toList(),
      smaFlSpots: (map['sma_flspots'] as Map<dynamic, dynamic>).entries.map((e) => Spots(date: DateTime.parse(e.key), value: e.value)).toList(),
    );
  }

  factory StatisticsModel.fromJson(String source) => StatisticsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StatisticsModel(energy: $energy, consumption: $consumption, inverterFlSpots: $inverterFlSpots, smaFlSpots: $smaFlSpots, smaPlus: $smaPlus, smaMinus: $smaMinus, chartType:$chartType)';
  }
}
