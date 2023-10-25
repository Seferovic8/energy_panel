import 'package:energy_panel/_all.dart';
import 'dart:html';

class RealtimeBloc extends Bloc<RealtimeEvent, RealtimeState> {
  RealtimeBloc() : super(initialState()) {
    on<LoadRealtimeEvent>(_load);
    on<SubmitRealtimeEvent>(_submit);
  }
  static RealtimeState initialState() => RealtimeState(status: RealtimeStateStatus.initial);

  Future _load(LoadRealtimeEvent event, Emitter<RealtimeState> emit) async {
    emit(state.copyWith(status: RealtimeStateStatus.submitting));
    final eventSource = EventSource('http://192.168.3.8:5000/events');

    eventSource.onMessage.listen((event) {
      add(SubmitRealtimeEvent(state: RealtimeState(status: RealtimeStateStatus.submittingSuccess, model: RealtimeModel.fromJson(event.data))));
    });
    eventSource.onError.listen((event) {
      add(SubmitRealtimeEvent(state: RealtimeState(status: RealtimeStateStatus.submittingError)));
    });
  }

  Future _submit(SubmitRealtimeEvent event, Emitter<RealtimeState> emit) async {
    emit(event.state.copyWith(model: event.state.model!.copyWith(consumption: state.model != null ? state.model!.consumption + event.state.model!.consumption : event.state.model!.consumption, inverter: state.model != null ? event.state.model!.inverter.copyWith(energy: state.model!.inverter.energy + event.state.model!.inverter.energy) : event.state.model!.inverter.copyWith(energy: event.state.model!.inverter.energy))));
  }
}
