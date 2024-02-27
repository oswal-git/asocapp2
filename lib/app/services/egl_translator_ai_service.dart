import 'dart:async';

import 'package:asocapp/app/utils/utils.dart';
// https://github.com/ManeraKai/simplytranslate_mobile/blob/main/lib/simplytranslate.dart
import 'package:simplytranslate/simplytranslate.dart';
// import 'package:translator/translator.dart';

class EglTranslatorAiService {
  // final translator = GoogleTranslator();
  final translator = SimplyTranslator(EngineType.google);

  Future<String> translate(String text, String languageTo) async {
    var textTranslated = text.trim();

    if (textTranslated != '') {
      try {
        // textTranslated = (await translator.trSimply(text.trim(), 'auto', languageTo));
        textTranslated = await translator.trSimply(text.trim(), 'auto', languageTo);
        return Future.value(textTranslated);
      } catch (e) {
        // Translation translation = {
        //   '',
        //   'Error $e',
        //   {'auto': 'Automatic'},
        //   {'error': '$e'}
        // } as Translation;
        // translation.targetLanguage.code == 'error' ? Helper.eglLogger('e', 'idAsoc') : null;
        EglHelper.eglLogger('e', 'translate -> $textTranslated: ${e.toString()}');
        return Future.value(textTranslated);
      }
    } else {
      return Future.value(textTranslated);
    }
  }
}
