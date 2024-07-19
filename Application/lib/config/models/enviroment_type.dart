enum EnvironmentType {
  development,
  staging,
  production,
}

extension EnvironmentTypeExtension on EnvironmentType {
  bool get isDevelopment => this == EnvironmentType.development;
  bool get isStaging => this == EnvironmentType.staging;
  bool get isProduction => this == EnvironmentType.production;

  String getName() {
    switch (this) {
      case EnvironmentType.development:
        return 'Development';
      case EnvironmentType.staging:
        return '';
      case EnvironmentType.production:
        return '';
      default:
        return '';
    }
  }
}