import 'dart:ui';

import 'translation_model.dart';

class LanguageModel {
  final String name;
  final String? iconPath;
  final Locale locale;
  final TranslationModel translation;

  LanguageModel({
    required String code,
    required this.name,
    this.iconPath,
    required this.translation,
  }) : locale = Locale(code);
}
