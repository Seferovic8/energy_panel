import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'translations/bs.dart';
import 'models/language_model.dart';
import 'models/translation_model.dart';

class Localizer {
  late TranslationModel translations;
  late LanguageModel currentLanguage;

  Localizer(Locale newLocale) {
    changeLanguage(newLocale);
  }

  void changeLanguage(Locale newLocale) {
    currentLanguage = supportedLanguages.firstWhere(
      (LanguageModel language) => language.locale.languageCode == newLocale.languageCode,
      orElse: () => defaultLanguage,
    );
    translations = currentLanguage.translation;
  }

  static final List<LanguageModel> supportedLanguages = [
    LanguageModel(
      code: 'bs',
      name: 'Lokalni',
      translation: translationBosnian,
      iconPath: 'assets/images/flags/flagBs.png',
    ),
    // LanguageModel(
    //   code: 'en',
    //   name: 'English',
    //   translation: translationEnglish,
    //   iconPath: 'assets/images/flags/flagEn.png',
    // ),
  ];

  static Localizer of(BuildContext context) {
    return Localizations.of<Localizer>(context, Localizer)!;
  }

  // ignore: library_private_types_in_public_api
  static const _Delegate delegate = _Delegate();

  static LanguageModel get defaultLanguage => supportedLanguages[0];

  static Locale getSupportedLocale(Locale? deviceLocale, Iterable<Locale>? supportedLocales) {
    if (deviceLocale == null) {
      return defaultLanguage.locale;
    }

    final deviceLocaleSupported = supportedLocales?.any((Locale locale) => deviceLocale.languageCode == locale.languageCode) ?? false;

    return deviceLocaleSupported ? deviceLocale : defaultLanguage.locale;
  }
}

class _Delegate extends LocalizationsDelegate<Localizer> {
  const _Delegate();

  @override
  bool isSupported(Locale locale) {
    return Localizer.supportedLanguages.map((language) => language.locale.languageCode).contains(locale.languageCode);
  }

  @override
  Future<Localizer> load(Locale locale) {
    return SynchronousFuture<Localizer>(Localizer(locale));
  }

  @override
  bool shouldReload(_Delegate old) => false;
}
