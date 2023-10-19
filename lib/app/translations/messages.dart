import 'package:get/get.dart';

import 'translations.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_GB': En().messages,
        'es_ES': Es().messages,
        'ca': Ca().messages,
      };
}
