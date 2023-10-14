import 'package:energy_panel/_all.dart';

@immutable
abstract class LocalizationEvent {}

class LoadLocalizationEvent extends LocalizationEvent {}

class ChangeLocalizationEvent extends LocalizationEvent {
  final Locale locale;

  ChangeLocalizationEvent({
    required this.locale,
  });
}
