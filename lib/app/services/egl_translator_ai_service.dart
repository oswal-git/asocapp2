import 'package:asocapp/app/utils/utils.dart';
import 'package:translator/translator.dart';

class EglTranslatorAiService {
  final translator = GoogleTranslator();

  Future<String> translate(String text, String languageTo) async {
    var textTrnaslated = text.trim();

    if (textTrnaslated != '') {
      try {
        textTrnaslated = (await translator.translate(text.trim(), to: languageTo)).text;
        return Future.value(textTrnaslated);
      } catch (e) {
        // Translation translation = {
        //   '',
        //   'Error $e',
        //   {'auto': 'Automatic'},
        //   {'error': '$e'}
        // } as Translation;
        // translation.targetLanguage.code == 'error' ? Helper.eglLogger('e', 'idAsoc') : null;
        EglHelper.eglLogger('e', 'translate -> $textTrnaslated: ${e.toString()}');
        return Future.value(textTrnaslated);
      }
    } else {
      return Future.value(textTrnaslated);
    }
  }
}
