// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workmanager/workmanager.dart';

import 'package:asocapp/app/services/storage_service.dart';
import 'package:asocapp/app/utils/utils.dart';

import '../models/models.dart';

class UserMessages {
  final String text;
  final String date;
  bool isRead;

  UserMessages({
    required this.text,
    required this.date,
    this.isRead = false,
  });
}

class SessionService extends GetxService {
  final StorageService _storage = Get.find<StorageService>();

  static const simplePeriodicTask = "simplePeriodicTask";

  final _thereIsInternetconnection = false.obs;
  bool get thereIsInternetconnection => _thereIsInternetconnection.value;
  set thereIsInternetconnection(bool value) => _thereIsInternetconnection.value = value;

  final _isThereTask = false.obs;
  get isThereTask => _isThereTask.value;
  set isThereTask(value) => _isThereTask.value = value;

  final _hasData = false.obs;
  bool get hasData => _hasData.value;
  set hasData(value) => _hasData.value = value;

  final _isLogin = false.obs;
  bool get isLogin => _isLogin.value;
  set isLogin(value) => _isLogin.value = value;

  final _isExpired = false.obs;
  bool get isExpired => _isExpired.value;
  set isExpired(value) => _isExpired.value = value;

  final _listUserMessages = <UserMessages>[].obs;
  List<UserMessages> get listUserMessages => _listUserMessages;
  void setListUserMessages(String value) => _listUserMessages.add(UserMessages(
        text: value,
        date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      ));
  set checkUserMessage(int value) {
    _listUserMessages[value].isRead = !_listUserMessages[value].isRead;
    _listUserMessages.refresh();
  }

  int get toReadmessages => _listUserMessages.where((message) => message.isRead == false).length;

  final _checkEdit = false.obs;
  bool get checkEdit => _checkEdit.value;
  set checkEdit(bool value) => _checkEdit.value = value;

  final _userConnected = Rx<UserConnected>(UserConnected.clear());
  UserConnected get userConnected => _userConnected.value;

  @override
  void onInit() {
    super.onInit();
    _listUserMessages.add(UserMessages(
      text: 'Registro de prueba',
      date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    ));

    initialize();
  }

// Update the logged in data user in session and shared preferences
  Future<void> updateUserConnected(UserConnected value, {bool loadTask = false}) async {
    _userConnected.value = value;

    if (userConnected.userNameUser != '') {
      _hasData.value = true;
      _isLogin.value = true;

      // Hora actual
      // Sumar 6 horas a la hora actual
      //  Obtener el valor en segundos para hacerlo comparable con PHP
      // int tokenExpUserInSeconds = (DateTime.now().add(const Duration(hours: 6)).millisecondsSinceEpoch ~/ 1000);
      int tokenExpUserInSeconds = (DateTime.now().millisecondsSinceEpoch ~/ 1000);

      _isExpired.value = (tokenExpUserInSeconds > userConnected.tokenExpUser);

      await _storage.writeObject(userConnectedKey, userConnected);

      await registerTask(loadTask);
      return;
    }

    await exitSession();
  }

  get getAuthToken => userConnected.tokenUser;

  Future<SessionService> initialize() async {
    Map<String, dynamic> userMap = _storage.readObject(userConnectedKey);

    if (userMap.isEmpty) {
      _userConnected.value = UserConnected.clear();
    } else {
      _userConnected.value = UserConnected.fromJson(userMap);
      if (_userConnected.value.userNameUser != '') {
        _hasData.value = true;
        _isLogin.value = true;
        await registerTask(true);
      }
    }
    _checkEdit.value = false;
    return this;
  }

  // Initialize the logged in data user in session
  void userClear() {
    _hasData.value = false;
    _isLogin.value = false;
    _checkEdit.value = false;
    _isExpired.value = false;
    _userConnected.value = UserConnected.clear();
  }

  Future<void> registerTask(bool loadTask) async {
    if (isLogin) {
      EglHelper.eglLogger('i', 'Session -> loadDataUser: isLogin? ${isLogin.toString()}');
      //   if (!isThereTask) {
      if (loadTask) {
        EglHelper.eglLogger('i', 'Session -> loadDataUser: isThereTask? ${_isThereTask.value.toString()}');
        Workmanager().cancelAll();
        if (userConnected.timeNotificationsUser != 99) {
          final int frequency = userConnected.timeNotificationsUser * 60;
          final int initialDelay = calcInitialDelay(userConnected.timeNotificationsUser);

          EglHelper.eglLogger('i', 'Session -> loadDataUser: timeNotificationsUser? ${userConnected.timeNotificationsUser.toString()}');
          isThereTask = true;
          EglHelper.eglLogger('i', 'Session -> loadDataUser: Workmanager().registerPeriodicTask');

          Workmanager().registerPeriodicTask(
            "5", simplePeriodicTask,
            existingWorkPolicy: ExistingWorkPolicy.replace,
            frequency: Duration(minutes: frequency), //when should it check the link
            initialDelay: Duration(seconds: initialDelay), //duration before showing the notification
            constraints: Constraints(
              networkType: NetworkType.connected,
            ),
          );
        }
      }
    }
  }

  int calcInitialDelay(int eachHours) {
    DateTime now = DateTime.now();
    String targetTime = "";

    switch (eachHours) {
      case 1:
        targetTime = "${now.hour + 1}:00:00";
        break;
      case 6:
        if (now.hour < 10) {
          targetTime = "10:00:00";
        } else if (now.hour < 16) {
          targetTime = "16:00:00";
        } else if (now.hour < 22) {
          targetTime = "22:00:00";
        } else {
          targetTime = "10:00:00";
        }
        break;
      case 12:
        if (now.hour < 10) {
          targetTime = "10:00:00";
        } else if (now.hour < 22) {
          targetTime = "22:00:00";
        } else {
          targetTime = "10:00:00";
        }
        break;
      case 24:
        targetTime = "10:00:00";
        break;
      default:
        targetTime = "10:00:00";
    }

    DateTime targetDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(targetTime.split(":")[0]), // Obtener la hora de targetTime
      int.parse(targetTime.split(":")[1]), // Obtener los minutos de targetTime
      int.parse(targetTime.split(":")[2]), // Obtener los segundos de targetTime
    );

    int secondsDifference = targetDateTime.difference(now).inSeconds;

    EglHelper.eglLogger('i', 'Session: calcInitialDelay -> secondsDifference: $secondsDifference');
    // return 4;
    return secondsDifference;
  }

  // Initialize the logged in data user in session and shared preferences
  Future<void> exitSession() async {
    userClear();
    Workmanager().cancelAll();
    await _storage.remove(userConnectedKey);
    var locale = const Locale('es', 'ES');
    Get.updateLocale(locale);
    Intl.defaultLocale = 'es_ES';
  }

  int setIdAsocAdmin(String profile, int asocId) {
    return ['superadmin', 'admin'].contains(profile) ? asocId : 0;
  }
}
