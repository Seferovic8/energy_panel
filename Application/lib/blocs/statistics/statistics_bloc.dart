import 'package:energy_panel/_all.dart';
import 'package:energy_panel/domain/repositories/statistics_repository.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  final IStatisticsRepository statisticsRepository;
  StatisticsBloc({required this.statisticsRepository}) : super(initialState()) {
    on<SubmitStatisticsEvent>(_submit);
  }
  static StatisticsState initialState() => StatisticsState(status: StatisticsStateStatus.initial);

  Future _submit(SubmitStatisticsEvent event, Emitter<StatisticsState> emit) async {
    emit(state.copyWith(status: StatisticsStateStatus.submitting));

    final data = await statisticsRepository.submit(event.statisticsModel);
    if (data == null) {
      emit(state.copyWith(status: StatisticsStateStatus.submittingError));
      return;
    }
    emit(state.copyWith(status: StatisticsStateStatus.submittingSuccess, model: data));
  }
}
