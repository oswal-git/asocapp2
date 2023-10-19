import 'package:asocapp/app/utils/utils.dart';
import 'package:translator/translator.dart';

class EglTranslatorAiService {
  final translator = GoogleTranslator();

  Future<Translation> translate(String text, String languageTo) async {
    try {
      return translator.translate(text, to: languageTo);
    } catch (e) {
      Translation translation = {
        '',
        'Error $e',
        {'auto': 'Automatic'},
        {'error': '$e'}
      } as Translation;
      translation.targetLanguage.code == 'error' ? Helper.eglLogger('e', 'idAsoc') : null;
      return Future.value(translation);
    }
  }
}
