// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:intl/intl.dart';

class GetStatisticsModel {
  final DateTime startDate;
  final DateTime endDate;
  GetStatisticsModel({
    required this.startDate,
    required this.endDate,
  });

  GetStatisticsModel copyWith({
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return GetStatisticsModel(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'startDate': DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(startDate),
      'endDate': DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(endDate),
    };
  }

  factory GetStatisticsModel.fromMap(Map<String, dynamic> map) {
    return GetStatisticsModel(
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate'] as int),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetStatisticsModel.fromJson(String source) => GetStatisticsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'StatisticsModel(startDate: $startDate, endDate: $endDate)';
}
