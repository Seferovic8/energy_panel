// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:energy_panel/_all.dart';

enum RealtimeStateStatus {
  initial,
  submitting,
  submittingSuccess,
  submittingError,
}

class RealtimeState {
  final RealtimeStateStatus status;
  final RealtimeModel? model;
  RealtimeState({
    required this.status,
    this.model,
  });

  RealtimeState copyWith({
    RealtimeStateStatus? status,
    RealtimeModel? model,
  }) {
    return RealtimeState(
      status: status ?? this.status,
      model: model ?? this.model,
    );
  }
}
