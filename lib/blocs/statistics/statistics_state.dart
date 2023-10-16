import 'package:energy_panel/_all.dart';

enum StatisticsStateStatus {
  initial,
  submitting,
  submittingSuccess,
  submittingError,
}

class StatisticsState {
  final StatisticsStateStatus status;
  final List<StatisticsModel>? model;
  StatisticsState({
    required this.status,
    this.model,
  });

  StatisticsState copyWith({
    StatisticsStateStatus? status,
    List<StatisticsModel>? model,
  }) {
    return StatisticsState(
      status: status ?? this.status,
      model: model ?? this.model,
    );
  }
}
