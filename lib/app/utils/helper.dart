import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:asocapp/app/config/config.dart';
import 'package:asocapp/app/models/models.dart';
import 'package:asocapp/app/resources/resources.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/widgets/widgets.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:timezone/data/latest.dart' as tzl;
import 'package:timezone/timezone.dart' as tz;

enum MessageType { info, warning, error }

class EglHelper {
  static void fieldFocus(BuildContext context, FocusNode currentNode, FocusNode nextFocus) {
    currentNode.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message, {bool webShowClose = false}) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.primaryTextTextColor,
      textColor: AppColors.whiteColor,
      fontSize: 16,
      webPosition: "top",
      gravity: ToastGravity.CENTER,
      // webShowClose: webShowClose,
      // timeInSecForIosWeb: 3,
    );
  }

  static dynamic showMultChoiceDialog(
    List<Map<String, dynamic>> questions,
    String question, {
    required BuildContext context,
    required ValueChanged<String> onChanged,
  }) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${'mSelectQuestion'.tr}?"),
        content: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: questions
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        onChanged(e['option']);
                      },
                      child: Column(
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Icon(
                                        e['icon'],
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 9,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              e['texto'],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          20.ph,
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  static void showPopMessage(
    BuildContext context,
    String title,
    String message, {
    required VoidCallback onPressed,
    String title2 = '',
    String message2 = '',
    EdgeInsets edgeInsetsPop = const EdgeInsets.fromLTRB(20, 80, 20, 20),
    String avatarUser = '',
    TextStyle styleTitle = const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
    TextStyle styleTitle2 = const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    TextStyle styleMessage = const TextStyle(fontSize: 30, fontWeight: FontWeight.normal),
    TextStyle styleMessage2 = const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
    ButtonStyle styleTextButton = const ButtonStyle(),
    StyleAvatarUser? styleAvatarUser,
    String textButton = 'Ok',
    Color textColorButton = AppColors.whiteColor,
    Color colorButton = AppColors.primaryMaterialColor,
    EdgeInsets edgeInsetsButton = const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 10.0),
    double fontSizeButton = 18.0,
    bool withImage = true,
  }) async =>
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => ShowSingleChoiceDialog(
          title: title,
          message: message,
          onPressed: onPressed,
          title2: title2,
          message2: message2,
          edgeInsetsPop: edgeInsetsPop,
          avatarUser: avatarUser,
          styleTitle: styleTitle,
          styleMessage: styleMessage,
          styleTitle2: styleTitle2,
          styleMessage2: styleMessage2,
          styleTextButton: styleTextButton,
          withImage: withImage,
          styleAvatarUser: styleAvatarUser ?? StyleAvatarUser(),
          textButton: textButton,
          textColorButton: textColorButton,
          colorButton: colorButton,
          edgeInsetsButton: edgeInsetsButton,
          fontSizeButton: fontSizeButton,
        ),
      );

  static popMessage(
    BuildContext context,
    MessageType messageType,
    String title,
    String message,
  ) {
    showDialog(
        context: context,
        builder: (context) {
          Color color = Colors.red;

          switch (messageType) {
            case MessageType.info:
              color = Colors.yellow;
              break;
            case MessageType.warning:
              color = Colors.orange;
              break;
            default:
              color = Colors.red;
              break;
          }

          return GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              title: Text(title),
              content: SizedBox(
                // width: double.infinity,
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: (() {
                        switch (messageType) {
                          case MessageType.info:
                            return const Icon(Icons.info_outline_rounded);
                          case MessageType.warning:
                            return const Icon(Icons.info_outline_rounded);
                          default:
                            return const Icon(Icons.info_outline_rounded);
                        }
                      })(),
                    ),
                  ),
                  Expanded(
                    child: Text(message),
                  ),
                ]),
              ),
              backgroundColor: color,
              // actions: const [],
            ),
          );
        });
  }

  static Future<String> apiURL() async {
    String apiURL = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    androidInfo.isPhysicalDevice ? apiURL = EglConfig.apiURLPhysicalDevice : apiURL = EglConfig.apiURLEmulatorDevice;

    // IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    // print('Is simulator: ${iosInfo.isPhysicalDevice}');
    return apiURL;
  }

  static Future<String> parseApiUrlBody(String responseBody) async {
    try {
      String apiUrl = await EglHelper.apiURL();
      //   eglLogger('w', 'responseBody: $responseBody');
      String replacedBody = responseBody.replaceAll(EglConfig.apiURLBD, apiUrl);
      //   eglLogger('w', 'replacedBody: $replacedBody');
      return replacedBody;
    } catch (_) {
      return responseBody;
    }
  }

  static dynamic eglLogger(String type, String message, {dynamic object = ''}) {
    final Logger logger = Logger();
    String resto = '';
    String fragmento = message;

    do {
      if (fragmento.length <= 950) {
        resto = '';
        fragmento = fragmento;
      } else {
        resto = fragmento.substring(950);
        fragmento = fragmento.substring(0, 950);
      }
      switch (type) {
        case 'i':
          object == '' ? logger.i('eglLogger(${obtenerFechaHoraActual()}): $fragmento') : logger.i('eglLogger: $fragmento, $object');
          break;
        case 'e':
          object == '' ? logger.e('eglLogger(${obtenerFechaHoraActual()}): $fragmento') : logger.e('eglLogger: $fragmento, $object');
          break;
        case 'd':
          object == '' ? logger.d('eglLogger(${obtenerFechaHoraActual()}): $fragmento') : logger.d('eglLogger: $fragmento, $object');
          break;
        case 'w':
          object == '' ? logger.w('eglLogger(${obtenerFechaHoraActual()}): $fragmento') : logger.w('eglLogger: $fragmento, $object');
          break;
        case 'v':
          object == '' ? logger.t('eglLogger(${obtenerFechaHoraActual()}): $fragmento') : logger.t('eglLogger: $fragmento, $object');
          break;
        default:
      }

      fragmento = resto;
      resto = '';
    } while (fragmento.isNotEmpty);
  }

  static String getAppCountryLocale(String language) {
    String country = '';
    switch (language) {
      case 'es':
        country = 'ES';
        break;
      case 'en':
        country = 'GB';
        break;
      default:
        country = '';
    }
    return country;
  }

  static DateTime obtenerFechaHoraActual() {
    // final now = DateTime.now();
    // Cargar la base de datos de zonas horarias
    tzl.initializeTimeZones();
    final now = tz.TZDateTime.now(tz.getLocation('Europe/Madrid'));
    final formatter = DateFormat('yyyy-MM-dd').add_Hms();
    return formatter.parse(formatter.format(now));
  }

  static DateTime aaaammddToDatetime(String aaaammdd) {
    final year = int.parse(aaaammdd.substring(0, 4));
    final month = int.parse(aaaammdd.substring(5, 7));
    final day = int.parse(aaaammdd.substring(8, 10));

    return DateTime(year, month, day);
  }

  static String datetimeToAaaammdd(DateTime date) {
    final year = date.year;
    final month = date.month;
    final day = date.day;

    return '$year-$month-$day';
  }

  static Map<dynamic, dynamic> getResolutionDevice() {
    // ignore: deprecated_member_use
    SingletonFlutterWindow window = WidgetsBinding.instance.window;
    double width = window.physicalSize.width;
    double height = window.physicalSize.height;
    double pixelRatio = window.devicePixelRatio;
    double dpWidth = width / pixelRatio;
    double dpHeight = height / pixelRatio;
    String sizeClass = '';
    switch (dpWidth) {
      case >= 0 && <= 600:
        sizeClass = 'compact';
        break;
      case <= 840.0:
        sizeClass = 'medium';
        break;
      default:
        sizeClass = 'expanded';
        break;
    }

    Map<dynamic, dynamic> resolutionDevice = {
      'width': width,
      'height': height,
      'pixelRatio': pixelRatio,
      'dpWidth': dpWidth,
      'dpHeight': dpHeight,
      'sizeClass': sizeClass,
    };

    return resolutionDevice;
  }

  static Future<Map<dynamic, dynamic>> getSizeImage(Image image, double? maxWidth) async {
    double rMaxWidth = maxWidth ?? Get.width;
    double iWidth = rMaxWidth;
    double iHeight = rMaxWidth / 2.0;

    Completer completer = Completer();
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo info, bool _) {
          completer.complete(info.image);
          iWidth = info.image.width.toDouble();
          iHeight = info.image.height.toDouble();

          final factor = rMaxWidth / iWidth;
          iHeight = factor * iHeight;
        },
      ),
    );
    final factor = rMaxWidth / iWidth;
    iHeight = factor * iHeight;

    Map<dynamic, dynamic> sizeImage = {
      'width': rMaxWidth,
      'height': iHeight,
    };

    return sizeImage;
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      String respText = '${text.substring(0, maxLength)}...';
      return respText;
    }
  }

  static bool osDarkMode(BuildContext context) => Theme.of(context).brightness == Brightness.dark;

  static Size screnSize() => MediaQuery.of(Get.context!).size;

  static double screnHeight() => MediaQuery.of(Get.context!).size.height;

  static double screnWidth() => MediaQuery.of(Get.context!).size.width;

  static Uint8List stringToUint8List(String dataImage) => const Base64Decoder().convert(dataImage);

  static String generateChain({int length = 8, String type = 'all'}) {
    String keyspace = '';

    switch (type) {
      case 'number':
        keyspace = EglKeysConfig.KEYSPACE_NUMBER;
        break;

      case 'letters':
        keyspace = EglKeysConfig.KEYSPACE_LETTERS;
        break;

      case 'all':
      default:
        keyspace = EglKeysConfig.KEYSPACE_ALL;
        break;
    }

    String str = '';
    int max = keyspace.length;
    Random rng = Random();
    if (max < 1) {
      eglLogger('e', 'keyspace must be at least two characters long');
      return '';
    }
    for (int i = 0; i < length; ++i) {
      str = '$str${keyspace[rng.nextInt(max)]}';
    }

    return str;
  }

  // end class
}
