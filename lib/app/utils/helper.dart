import 'dart:async';
import 'dart:convert';
import 'dart:io';
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
import 'package:html/parser.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:timezone/data/latest.dart' as tzl;
import 'package:timezone/timezone.dart' as tz;

enum MessageType { info, warning, error }

typedef ValidateCallback = String Function(String text);

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

  static Future<void> showPopMessage(
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

  // Para mostrar avisos
  static Future<void> popMessage(
    BuildContext context,
    MessageType messageType,
    String title,
    String message,
  ) async {
    await showDialog(
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

  static Future<bool?> showConfirmationPopup({
    String title = '¿Estás seguro de continuar?',
    String message = '',
    String textOkButton = 'Confirmar',
    Color textColorOkButton = AppColors.whiteColor,
    Color colorOkButton = AppColors.primaryMaterialColor,
    String textCancelButton = 'Cancelar',
    Color textColorCancelButton = AppColors.whiteColor,
    Color colorCancelButton = AppColors.primaryMaterialColor,
  }) async {
    bool? result = await Get.defaultDialog(
      title: title,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(message, textAlign: TextAlign.center, style: const TextStyle()),
            20.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.back(result: true); // Confirmar
                  },
                  child: Text(textOkButton),
                ),
                const SizedBox(width: 20),
                OutlinedButton(
                  onPressed: () {
                    Get.back(result: false); // Cancelar
                  },
                  child: Text(textCancelButton),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    return result;
  }

  static Future<void> editTextField(
    BuildContext context, {
    String title = 'Edit text',
    String text = '',
    double height = 550,
    int maxCaracters = 0,
    bool toolbarPos = true,
    required ValueChanged<String> onUpdate,
    required ValidateCallback onValidate,
  }) async {
    final HtmlEditorController htmlEditorController = HtmlEditorController();

    String textBefore = text;
    String textValidate = '';
    String plainText = parse(textBefore).documentElement!.text;
    int lengthPlainText = plainText.length;

    List<Toolbar> defaultToolbarButtons = [
      const StyleButtons(
        style: false,
      ),
      const FontSettingButtons(
        fontName: true,
        fontSize: true,
        fontSizeUnit: false,
      ),
      const FontButtons(
        bold: true,
        italic: true,
        underline: true,
        clearAll: false,
        strikethrough: true,
        superscript: true,
        subscript: true,
      ),
      const ColorButtons(
        foregroundColor: true,
        highlightColor: true,
      ),
      const ListButtons(
        ul: false,
        ol: false,
        listStyles: false,
      ),
      const ParagraphButtons(
        alignLeft: true,
        alignCenter: true,
        alignRight: true,
        alignJustify: true,
        increaseIndent: false,
        decreaseIndent: false,
        textDirection: false,
        lineHeight: true,
        caseConverter: true,
      ),
      const InsertButtons(
        link: false,
        picture: false,
        audio: false,
        video: false,
        otherFile: false,
        table: false,
        hr: false,
      ),
      const OtherButtons(
        fullscreen: false,
        codeview: false,
        undo: true,
        redo: true,
        help: false,
        copy: false,
        paste: false,
      ),
    ];

    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        titlePadding: const EdgeInsets.only(left: 20.0, top: 8),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    Get.back();
                  },
                  icon: const Icon(Icons.close),
                ),
                IconButton(
                  onPressed: () async {
                    String txtSalida = await htmlEditorController.getText();
                    if (txtSalida.contains('src="data:')) {
                      txtSalida = '<text removed due to base-64 data, displaying the text could cause the app to crash>';
                    }
                    Get.back();
                    onUpdate(txtSalida);
                  },
                  icon: const Icon(Icons.check),
                ),
              ],
            )
          ],
        ),
        content: Container(
          width: MediaQuery.of(context).size.width - 30,
          // height: MediaQuery.of(context).size.height - 30,
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            // borderRadius: BorderRadius.circular(50.0), // ajusta el radio según sea necesario
            border: Border(
              bottom: BorderSide(
                color: Colors.red, // color del borde
                width: 2.0, // ancho del borde
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5.0, right: 10.0, left: 10.0),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      textValidate,
                      style: TextStyle(fontSize: 12, color: Colors.red[600]),
                    ),
                    Text(
                      lengthPlainText.toString(),
                      style: TextStyle(fontSize: 12, color: Colors.blue[600]),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white70,
                  height: 250,
                  child: HtmlEditor(
                    controller: htmlEditorController, //required
                    htmlEditorOptions: HtmlEditorOptions(
                      initialText: text,
                      hint: "Your text here...",
                      characterLimit: maxCaracters > 0 ? maxCaracters : null,
                      // shouldEnsureVisible: true,
                      autoAdjustHeight: true,
                      adjustHeightForKeyboard: false,
                      spellCheck: true,
                    ),
                    htmlToolbarOptions: HtmlToolbarOptions(
                      toolbarPosition: toolbarPos ? ToolbarPosition.aboveEditor : ToolbarPosition.belowEditor,
                      toolbarType: ToolbarType.nativeScrollable,
                      toolbarItemHeight: 22,
                      defaultToolbarButtons: defaultToolbarButtons,
                    ),
                    otherOptions: OtherOptions(
                      height: height,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: const Color.fromARGB(255, 248, 246, 244),
                          width: 2,
                        ),
                      ),
                    ),
                    callbacks: Callbacks(
                      onChangeContent: (String? changed) async {
                        EglHelper.eglLogger('i', 'content changed to $changed');
                        plainText = parse(changed).documentElement!.text;
                        lengthPlainText = plainText.length;
                        // textValidate = validateText(plainText, minLength: 4, maxLength: 100);
                        textValidate = onValidate(plainText);
                        // htmlEditorController.addNotification(
                        //     '<div style="display:flex; justify-content:space-between; align-items:center;"><div style="color: red;">$textValidate</div><div>${changed!.length.toString()}</div></div>',
                        //     NotificationType.info);
                        (context as Element).markNeedsBuild();
                      },
                      onFocus: () {
                        EglHelper.eglLogger('i', 'editor focused');
                      },
                      onInit: () {
                        EglHelper.eglLogger('i', 'editor inited');
                        htmlEditorController.setFocus();
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(backgroundColor: Colors.blueGrey),
                      onPressed: () {
                        htmlEditorController.toggleCodeView();
                      },
                      child: const Text('Html code', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<String> apiURL() async {
    String apiURL = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      apiURL = androidInfo.isPhysicalDevice ? EglConfig.apiURLPhysicalDevice : EglConfig.apiURLEmulatorDevice;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      eglLogger('i', 'El dispositivo es un emulador: ${iosInfo.isPhysicalDevice}');
      eglLogger('i', 'Tipo de dispositivo: ${iosInfo.utsname.machine}');
    }

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
    final String month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

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

  static String getNameFilePath(String path, {String fileSeparator = '/', String extSeparator = '.'}) {
    int posIni = path.lastIndexOf(fileSeparator) == -1 ? 0 : path.lastIndexOf(fileSeparator) + 1;
    int posFin = path.lastIndexOf(extSeparator) == -1 ? path.length : path.lastIndexOf(extSeparator);
    posFin = posFin > posIni ? posFin : path.length;
    String name = path.substring(posIni, posFin);
    return name;
  }

  static String getExtFilePath(String path, {String fileSeparator = '/', String extSeparator = '.'}) {
    int posIni = path.lastIndexOf(extSeparator) == -1 ? path.length : path.lastIndexOf(extSeparator) + 1;
    String ext = path.substring(posIni, path.length);
    return ext;
  }

// functions
  static String validateText(String text, {int minLength = 0, int maxLength = 99999}) {
    String textValidate = '';

    if (text.isEmpty && minLength > 0) {
      textValidate = 'Introduzca el título del artículo';
    } else if (text.length < minLength) {
      textValidate = 'El título ha de tener $minLength carácteres como mínimo ';
    } else if (text.length > maxLength) {
      textValidate = 'El título ha de tener $maxLength carácteres como máximo ';
      // controller.getTe
    } else {
      textValidate = '';
    }
    return textValidate;
  }

  static List<ItemArticle> copyListItems(List<ItemArticle> list1) {
    List<ItemArticle> list2 = [];

    if (list1.isNotEmpty) {
      list2 = list1.map((ItemArticle item) => item.copyWith()).toList();
      // Llamar al método 'myMethod' dinámicamente
    }

    return list2;
  }

  static bool listsAreEqual(List<dynamic> list1, List<dynamic> list2) {
    if (list1.length != list2.length) {
      return false;
    }

    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) {
        return false;
      }
    }

    return true;
  }
  // end class
}
