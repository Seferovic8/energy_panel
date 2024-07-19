// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:energy_panel/_all.dart';

@immutable
abstract class StatisticsEvent {}

class SubmitStatisticsEvent extends StatisticsEvent {
  final GetStatisticsModel statisticsModel;
  SubmitStatisticsEvent({
    required this.statisticsModel,
  });
}
