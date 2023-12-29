import 'package:asocapp/app/utils/utils.dart';
import 'package:translator/translator.dart';

class EglTranslatorAiService {
  final translator = GoogleTranslator();

  Future<String> translate(String text, String languageTo) async {
    var textTranslated = text.trim();

    if (textTranslated != '') {
      try {
        textTranslated = (await translator.translate(text.trim(), to: languageTo)).text;
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
