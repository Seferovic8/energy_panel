import 'package:energy_panel/_all.dart';
import 'dart:html';

class RealtimeBloc extends Bloc<RealtimeEvent, RealtimeState> {
  RealtimeBloc() : super(initialState()) {
    on<LoadRealtimeEvent>(load);
    on<SubmitRealtimeEvent>(submit);
  }
  static RealtimeState initialState() => RealtimeState(status: RealtimeStateStatus.initial);

  Future load(LoadRealtimeEvent event, Emitter<RealtimeState> emit) async {
    emit(state.copyWith(status: RealtimeStateStatus.submitting));
    final eventSource = EventSource('http://192.168.3.8:5000/events');

    eventSource.onMessage.listen((event) {
      // print(event.data);
      add(SubmitRealtimeEvent(state: RealtimeState(status: RealtimeStateStatus.submittingSuccess, model: RealtimeModel.fromJson(event.data))));
    });
    eventSource.onError.listen((event) {
      add(SubmitRealtimeEvent(state: RealtimeState(status: RealtimeStateStatus.submittingError)));
    });
  }

  Future submit(SubmitRealtimeEvent event, Emitter<RealtimeState> emit) async {
    emit(event.state.copyWith(model: event.state.model!.copyWith(consumption: state.model != null ? state.model!.consumption + event.state.model!.consumption : event.state.model!.consumption)));
  }
}
