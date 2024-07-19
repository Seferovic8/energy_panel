class AppSettings {
  final String name;
  final String description;
  final String version;
  final String versionDisplay;
  final String packageName;
  final String appleServiceId;
  final String restapiurl;
  final String eventsUrl;
  final String lastUrl;
  final bool logNetworkTraffic;
  final bool keepRetryingOnNetworkError;
  final bool providesOfflineMode;
  final bool resetStorageOnRestart;
  final bool onlyAllowOrientationPortrait;
  final bool skipIntro;
  final bool skipLogin;
  final bool skipAllowLocation;
  final bool usingExceptionReporting;
  final String stripeCheckoutUrl;
  final String appleRedirectUrl;
  AppSettings({
    this.name = 'Cafe&Snack Digital',
    this.description = 'Cafe&Snack Digital project',
    this.version = '1.0',
    this.versionDisplay = '1.0.32',
    this.packageName = 'com.seferovic.cafesnackdigital',
    this.restapiurl = '',
    required this.eventsUrl,
    required this.lastUrl,
    this.stripeCheckoutUrl = '',
    this.logNetworkTraffic = true,
    this.keepRetryingOnNetworkError = true,
    this.providesOfflineMode = true,
    this.resetStorageOnRestart = false,
    this.onlyAllowOrientationPortrait = true,
    this.skipIntro = false,
    this.skipLogin = true,
    this.skipAllowLocation = false,
    this.usingExceptionReporting = false,
    this.appleRedirectUrl = '',
    this.appleServiceId = '',
  });
}
