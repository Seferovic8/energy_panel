// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:energy_panel/_all.dart';

class StatisticsModel {
  final DateTime startDate;
  final DateTime endDate;
  final double energy;
  final double consumption;
  final List<FlSpot> inverterFlSpots;
  final List<FlSpot> smaFlSpots;
  StatisticsModel({
    required this.startDate,
    required this.endDate,
    required this.energy,
    required this.consumption,
    required this.inverterFlSpots,
    required this.smaFlSpots,
  });

  StatisticsModel copyWith({
    DateTime? startDate,
    DateTime? endDate,
    double? energy,
    double? consumption,
    List<FlSpot>? inverterFlSpots,
    List<FlSpot>? smaFlSpots,
  }) {
    return StatisticsModel(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      energy: energy ?? this.energy,
      consumption: consumption ?? this.consumption,
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
      inverterFlSpots: (map['inverter_flspots'] as Map<dynamic, dynamic>).entries.map((e) => FlSpot(double.parse(e.key), e.value)).toList(),
      smaFlSpots: (map['sma_flspots'] as Map<dynamic, dynamic>).entries.map((e) => FlSpot(double.parse(e.key), e.value)).toList(),
    );
  }

  factory StatisticsModel.fromJson(String source) => StatisticsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StatisticsModel(energy: $energy, consumption: $consumption, inverterFlSpots: $inverterFlSpots, smaFlSpots: $smaFlSpots)';
  }
}
