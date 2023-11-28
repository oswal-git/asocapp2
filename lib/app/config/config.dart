import 'package:asocapp/app/utils/helper.dart';

class Config {
  static const String protocol = 'http://';
  static const String apiURLBD = 'apiasoc.es';
  // static const String apiURL = 'localhost/apiasoc';
  static const String apiURLEmulatorDevice = '10.0.2.2/apiasoc'; // emulator local
  static const String apiURLPhysicalDevice = '192.168.1.20/apiasoc'; // device móvil

  // static const String apiURL = '10.0.2.2:7251';
  // static const String apiURL = '192.168.1.20:7251';

  static const String apiListAll = 'list-all.php';
  static const String apiSingleArticle = 'single-article.php';

  static const String apiListAllQuestions = 'list-questions.php';
  static const String apiListPending = 'list-pending.php';
  static const String apiUserLogin = 'user-login.php';
  static const String apiUserProfile = 'profile.php';
  static const String apiUserProfileAvatar = 'profile-upload.php';
  static const String apiValidateKey = 'validate-answer.php';
  static const String apiCreateUser = 'create';
  static const String apiRegister = 'register.php';
  static const String apiReset = 'reset.php';
  static const String apiChange = 'change.php';
  static const String apiRegisterGenericUser = 'register-generic.php';

  static const String apiSeparator = '/';
  static const String apiKeyGPT = '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';

  static Future<Uri> uri(String endPoint, String action) async {
    String apiURL = await Helper.apiURL();

    // return Uri.http(apiURL, '$endPoint$apiSeparator$action');
    return Uri.parse("$protocol$apiURL/$endPoint/$action");
  }
}
