// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  Language(
    this.id,
    this.flag,
    this.name,
    this.languageCode,
  );

  static List<Language> languageList() {
    return <Language>[
      Language(1, "🇪🇸", 'Castellano', 'es'),
      Language(1, "🏴󠁥󠁳󠁶󠁣󠁿", 'Valencià', 'ca'),
      Language(1, "🇬🇧", 'English', 'en'),
    ];
  }

  static getLanguageList() {
    List<Language> langs = languageList();

    List<dynamic> res = langs
        .map((lang) => {
              'id': lang.languageCode,
              'name': '${lang.flag}  ${lang.name.tr}',
            })
        .toList();
    return res;
  }
}
