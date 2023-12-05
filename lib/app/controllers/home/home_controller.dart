import 'dart:async';

import 'package:asocapp/app/services/session_service.dart';
import 'package:asocapp/app/views/auth/login/login_page.dart';
import 'package:asocapp/app/views/dashboard/dashboard_page.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  SessionService session = Get.put<SessionService>(SessionService());

  @override
  void onInit() async {
    super.onInit();
    await isLogin();
  }

  Future<void> isLogin() async {
    if (session.isLogin) {
      Timer(const Duration(seconds: 3), () => Get.to(() => const DashboardPage()));
    } else {
      // Timer(const Duration(seconds: 3), () => Navigator.pushNamed(context, RouteName.register));
      Timer(const Duration(seconds: 3), () => Get.to(() => const LoginPage()));
    }
  }
}
