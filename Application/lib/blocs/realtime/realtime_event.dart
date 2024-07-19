// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:energy_panel/_all.dart';

@immutable
abstract class RealtimeEvent {}

class LoadRealtimeEvent extends RealtimeEvent {}

class SubmitRealtimeEvent extends RealtimeEvent {
  final RealtimeState state;
  SubmitRealtimeEvent({
    required this.state,
  });
}
