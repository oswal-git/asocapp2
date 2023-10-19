import 'dart:io';
import 'package:asocapp/app/resources/resources.dart';
import 'package:asocapp/app/services/services.dart';
import 'package:asocapp/app/translations/messages.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/number_symbols.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';
import 'package:workmanager/workmanager.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  await Get.putAsync(() => NotificationService().initialize());
  await Get.putAsync(() => SessionService().initialize());

  Helper.eglLogger('i', 'main: Workmanager().initialize:');

  Workmanager().initialize(
    callbackDispatcher,
    // isInDebugMode: true,
  );

  Helper.eglLogger('i', 'main: Workmanager().cancelAll');
  // Cancelar todas las tareas programadas previamente
  Workmanager().cancelAll();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // Only after at least the action method is set, the notification events are delivered
    Helper.eglLogger('i', '_MyAppState - initState: AwesomeNotifications().setListeners:');

    NotificationService.setListeners(context);

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SessionService session = Get.put<SessionService>(SessionService());

    // session.initialize();
    String language = 'es';
    String country = 'ES';

    if (session.isLogin) {
      language = session.userConnected.languageUser;
      country = Helper.getAppCountryLocale(language);
    }

    initializeDateFormatting(country == '' ? language : '${language}_$country', null);
    final esES = numberFormatSymbols['es_ES'] as NumberSymbols;
    final caVL = numberFormatSymbols['ca'] as NumberSymbols;
    final enGB = numberFormatSymbols['en_GB'] as NumberSymbols;

    numberFormatSymbols['es_ES'] = esES.copyWith(currencySymbol: r'€');
    numberFormatSymbols['ca'] = caVL.copyWith(currencySymbol: r'€');
    numberFormatSymbols['en_GB'] = enGB.copyWith(currencySymbol: r'$');

    return GetMaterialApp(
      translations: Messages(),
      locale: Locale(language, country),
      fallbackLocale: const Locale('es', 'ES'),
      debugShowCheckedModeBanner: false,
      title: 'Asociaciones',
      theme: ThemeData(
        primarySwatch: AppColors.primaryMaterialColor,
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: EglInputTheme().theme(),
        appBarTheme: const AppBarTheme(
          color: AppColors.whiteColor,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 22,
            color: AppColors.primaryTextTextColor,
          ),
          toolbarTextStyle: TextStyle(
            fontSize: 40,
            color: AppColors.primaryTextTextColor,
            fontWeight: FontWeight.w500,
            height: 1.6,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().executeTask((task, inputData) async {
    NotificationService notificationService = Get.put<NotificationService>(NotificationService());

    if (Platform.isAndroid) SharedPreferencesAndroid.registerWith();

    DateTime now = DateTime.now();
    Helper.eglLogger('i', 'callbackDispatcher: task:', object: task);
    switch (task) {
      case simplePeriodicTask:

        // Code to run in background
        Helper.eglLogger('i', "Native called background task: $task"); //simpleTask will be emitted here.
        if (now.hour >= 0 && now.hour <= 24) {
          // if (now.hour >= 10 && now.hour <= 22) {
          Map<dynamic, dynamic> response = await notificationService.getPendingNotifyArticlesList();
          Helper.eglLogger('i', 'callbackDispatcher: task: Datos cargados - response.toString:', object: response.toString());

          // Recorriendo la lista con un bucle for
          if (response['list'].isNotEmpty) {
            for (int i = 0; i < response['list'].length; i++) {
              dynamic item = response['list'][i];
              Helper.eglLogger('i', 'callbackDispatcher: task: createArticleNotification - item:', object: item);

              await NotificationService.createArticleNotification(item);

              //   Helper.eglLogger('i', 'callbackDispatcher: task: createArticleNotification:');
            }
          }
        } else {
          Helper.eglLogger('i', 'callbackDispatcher: task: createArticleNotification -> no message (${now.hour})');
        }

        break;
    }
    return Future.value(true);
  });
}
