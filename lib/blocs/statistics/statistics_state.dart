import 'package:energy_panel/_all.dart';

enum StatisticsStateStatus {
  initial,
  submitting,
  submittingSuccess,
  submittingError,
}

class StatisticsState {
  final StatisticsStateStatus status;
  final RealtimeModel? model;
  StatisticsState({
    required this.status,
    this.model,
  });

  StatisticsState copyWith({
    StatisticsStateStatus? status,
    RealtimeModel? model,
  }) {
    return StatisticsState(
      status: status ?? this.status,
      model: model ?? this.model,
    );
  }
}
