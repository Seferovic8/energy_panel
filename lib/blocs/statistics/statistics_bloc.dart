import 'package:energy_panel/_all.dart';
import 'package:energy_panel/domain/repositories/statistics_repository.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  final IStatisticsRepository statisticsRepository;
  StatisticsBloc({required this.statisticsRepository}) : super(initialState()) {
    on<SubmitStatisticsEvent>(submit);
  }
  static StatisticsState initialState() => StatisticsState(status: StatisticsStateStatus.initial);

  Future submit(SubmitStatisticsEvent event, Emitter<StatisticsState> emit) async {
    emit(state.copyWith(status: StatisticsStateStatus.submitting));

    final data = await statisticsRepository.submit(event.statisticsModel);
    print(data![0]);
  }
}
