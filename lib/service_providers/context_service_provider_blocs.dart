import 'package:energy_panel/_all.dart';

class ContextServiceProviderBloc extends StatelessWidget {
  final Widget child;

  const ContextServiceProviderBloc({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocalizationBloc>(
          create: (context) => LocalizationBloc(),
        ),
        BlocProvider<RealtimeBloc>(
          create: (context) => RealtimeBloc()..add(LoadRealtimeEvent()),
        ),
        BlocProvider<StatisticsBloc>(
          create: (context) => StatisticsBloc(statisticsRepository: context.serviceProvider.statisticsRepository),
        ),
        BlocProvider<PeriodSelectionBloc>(
          create: (context) => PeriodSelectionBloc(),
        ),

        // BlocProvider<VideoBloc>(
        //   create: (context) => VideoBloc(),
        // ),
      ],
      child: child,
    );
    // return child;
  }
}
