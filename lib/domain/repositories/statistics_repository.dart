// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:energy_panel/_all.dart';

abstract class IStatisticsRepository {
  Future<StatisticsModel?> submit(GetStatisticsModel statisticsModel);
}

class StatisticsRepository extends IStatisticsRepository {
  final AppSettings appSettings;
  StatisticsRepository({
    required this.appSettings,
  });
  @override
  Future<StatisticsModel?> submit(GetStatisticsModel statisticsModel) async {
    try {
      final response = await http.post(
        Uri.parse(appSettings.lastUrl),
        body: statisticsModel.toJson(),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      final Map<String, dynamic> resp = json.decode(response.body);
      return StatisticsModel.fromMap(resp);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
