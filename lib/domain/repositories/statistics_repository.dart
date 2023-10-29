import 'package:energy_panel/_all.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class IStatisticsRepository {
  Future<StatisticsModel?> submit(GetStatisticsModel statisticsModel);
}

class StatisticsRepository extends IStatisticsRepository {
  @override
  Future<StatisticsModel?> submit(GetStatisticsModel statisticsModel) async {
    try {
      final response = await http.post(
        //Uri.parse('http://192.168.3.8:5000/get_last'),
        Uri.parse('http://192.168.3.8:5000/get_last'),
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
