import 'package:energy_panel/_all.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc() : super(LocalizationState(locale: Localizer.defaultLanguage.locale)) {
    on<LoadLocalizationEvent>(load);
    on<ChangeLocalizationEvent>(change);
  }
  static LocalizationState initialState() => LocalizationState(locale: Localizer.defaultLanguage.locale);

  Future load(LoadLocalizationEvent event, Emitter<LocalizationState> emit) async {
//final languageCode = await storageRepository.get(AppKeys.languageCode);
    // final locale = languageCode == null ? Localizer.defaultLanguage.locale : Locale(languageCode);
    final locale = Localizer.defaultLanguage.locale;
    emit(state.copyWith(locale: locale));
  }

  Future change(ChangeLocalizationEvent event, Emitter<LocalizationState> emit) async {}
}
