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
          create: (context) => RealtimeBloc(),
        ),
        BlocProvider<StatisticsBloc>(
          create: (context) => StatisticsBloc(statisticsRepository: context.serviceProvider.statisticsRepository),
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
