import 'package:energy_panel/_all.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class IStatisticsRepository {
  Future<List<StatisticsModel>?> submit(GetStatisticsModel statisticsModel);
}

class StatisticsRepository extends IStatisticsRepository {
  Future<List<StatisticsModel>?> submit(GetStatisticsModel statisticsModel) async {
    print('uso');
    try {
      final response = await http.post(
        Uri.parse('http://192.168.3.8:3000/get_last'),
        body: statisticsModel.toJson(),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      //final response = await dio.post('http://192.168.3.8:3000/get_last', data: statisticsModel.toJson());
      final List<dynamic> resp = json.decode(response.body);
      final data = resp.map((e) {
        return StatisticsModel.fromMap(e);
      }).toList();
      return data;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
