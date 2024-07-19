import 'package:energy_panel/_all.dart';

class PeriodSelectionBloc extends Bloc<PeriodSelectionEvent, PeriodSelectionState> {
  PeriodSelectionBloc() : super(initialState()) {
    on<ChangeSelctedPeriod>(_change);
  }
  static PeriodSelectionState initialState() => PeriodSelectionState(selected: SelectedPeriodButton.today);

  Future _change(ChangeSelctedPeriod event, Emitter<PeriodSelectionState> emit) async {
    emit(state.copyWith(selected: event.selected));
  }
}
