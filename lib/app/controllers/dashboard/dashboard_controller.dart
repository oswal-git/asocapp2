import 'dart:async';

import 'package:asocapp/app/services/session_service.dart';
import 'package:asocapp/app/views/auth/change/change_page.dart';
import 'package:asocapp/app/views/auth/login/login_page.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class DashboardController extends GetxController {
  final SessionService session = Get.put(SessionService());

  final Logger logger = Logger();

  final _loading = true.obs;
  bool get loading => _loading.value;
  set loading(value) => _loading.value = value;

  @override
  void onInit() async {
    super.onInit();
    await isLogin();
  }

  Future<void> isLogin() async {
    if (session.isLogin) {
      // Utils.eglLogger('e', 'ArticlesListView: init State isLogin');
      if (session.userConnected.recoverPasswordUser != 0) {
        Timer(const Duration(seconds: 3), () => Get.offAll(const ChangePage()));
      } else {
        _loading.value = false;
      }
    } else {
      Timer(const Duration(seconds: 3), () => Get.offAll(const LoginPage()));
    }
  }
}
