import 'package:energy_panel/_all.dart';
import 'package:energy_panel/domain/repositories/statistics_repository.dart';

class DevelopmentServiceProvider extends ServiceProvider {
  @override
  Future<void> initAppSettings() async => appSettings = developmentAppSettings;
}

class StagingServiceProvider extends ServiceProvider {
  @override
  Future<void> initAppSettings() async => appSettings = productionAppSettings;
}

class ProductionServiceProvider extends ServiceProvider {
  @override
  Future<void> initAppSettings() async => appSettings = productionAppSettings;
}

abstract class ServiceProvider {
  late AppSettings appSettings;
  late IStatisticsRepository statisticsRepository;

  Future<void> initAppSettings();
  Future<void> initRespositories() async {
    statisticsRepository = StatisticsRepository();
  }

  Future<void> init() async {
    await initAppSettings();
    await initRespositories();
  }
}

Future<ServiceProvider> resolveServiceProviderFromEnvironment() async {
  ServiceProvider serviceProvider;
  switch (environment) {
    case EnvironmentType.development:
      serviceProvider = DevelopmentServiceProvider();
      break;
    case EnvironmentType.staging:
      serviceProvider = StagingServiceProvider();
      break;
    case EnvironmentType.production:
      serviceProvider = ProductionServiceProvider();
      break;
  }
  await serviceProvider.init();

  return serviceProvider;
}
