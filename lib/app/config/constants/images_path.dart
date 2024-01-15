import 'package:asocapp/app/config/config.dart';
import 'package:asocapp/app/utils/utils.dart';

class EglImagesPath {
  static String appIconUserDefault = '';
  static String appCoverDefault = '';

  EglImagesPath() {
    getAppIconUserDefault().then((image) {
      appIconUserDefault = image;
    });
    getCoverDefault().then((cover) {
      appCoverDefault = cover;
    });
  }

  static const String lightAppLogo = 'assets/images/eglos_logo.png';
  static const String darkAppLogo = 'assets/images/eglos_logo.png';

  static const String nameIconUserDefaultProfile = 'icons_user_profile_circle.png';
  static const String iconUserDefaultProfile = 'assets/images/$nameIconUserDefaultProfile';
  static const String coverDefault = 'assets/images/camara1.png';

  static const String iconBackgroundDrawer =
      'https://thumbs.dreamstime.com/b/vista-del-paisaje-mediterr%C3%A1neo-hermoso-del-mar-y-del-cielo-soleado-67838267.jpg';

  static Future<String> getAppIconUserDefault() async {
    String apiURL = await EglHelper.apiURL();
    final appIconUserDefault = Uri.parse("${EglConfig.protocol}$apiURL/$iconUserDefaultProfile").toString();
    return appIconUserDefault;
  }

  static Future<String> getCoverDefault() async {
    String apiURL = await EglHelper.apiURL();
    final appCoverDefault = Uri.parse("${EglConfig.protocol}$apiURL/$coverDefault").toString();
    return appCoverDefault;
  }
}
