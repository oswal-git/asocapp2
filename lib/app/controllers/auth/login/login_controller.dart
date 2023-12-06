import 'dart:async';

import 'package:asocapp/app/apirest/api_models/api_models.dart';
import 'package:asocapp/app/controllers/asociation/asociation_controller.dart';
import 'package:asocapp/app/models/models.dart';
import 'package:asocapp/app/repositorys/user_repository.dart';
import 'package:asocapp/app/services/services.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/views/auth/change/change_page.dart';
import 'package:asocapp/app/views/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class LoginController extends GetxController {
  final SessionService session = Get.put(SessionService());
  final AsociationController asociationController = Get.put(AsociationController());
  final UserRepository userRepository = Get.put(UserRepository());

  UserConnected? userConnected = UserConnected.clear();

  final Logger logger = Logger();

  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: '_loginController');

  final _asociationsFocusNode = FocusNode().obs;
  FocusNode get asociationsFocusNode => _asociationsFocusNode.value;

  final _passwordFocusNode = FocusNode().obs;
  FocusNode get passwordFocusNode => _passwordFocusNode.value;

  final _userNameFocusNode = FocusNode().obs;
  FocusNode get userNameFocusNode => _userNameFocusNode.value;

  final _password = ''.obs;
  String get password => _password.value;
  set password(String value) => _password.value = value;

  final _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;

  @override
  Future<void> onInit() async {
    super.onInit();
    EglHelper.eglLogger('i', '$runtimeType');

    await isLogin();

    _userNameFocusNode.value.addListener(() {
      // Utils.eglLogger('i', "UserName has focus: ${userNameFocusNode.hasFocus}");
    });
  }

  @override
  void onClose() {
    EglHelper.eglLogger('i', '$runtimeType');

    _asociationsFocusNode.value.dispose();
    _passwordFocusNode.value.dispose();
    _userNameFocusNode.value.dispose();

    super.onClose();
  }

  Future<void> isLogin() async {
    if (session.isLogin) {
      if (session.userConnected.recoverPasswordUser == 0) {
        Timer(const Duration(seconds: 3), () => Get.to(() => const DashboardPage()));
      }
      // Timer(const Duration(seconds: 3), () => Navigator.pushNamed(context, RouteName.register));
      Timer(const Duration(seconds: 3), () => Get.to(() => const ChangePage()));
    }
  }

  bool isLogged() => session.isLogin;

  Future<void> updateUserConnected(UserConnected value, {bool loadTask = false}) async {
    await session.updateUserConnected(
      value,
      loadTask: loadTask,
    );
  }

  Future<List<dynamic>> refreshAsociationsList() async {
    return asociationController.refreshAsociationsList();
  }

  Future<UserAsocResponse?> login(String username, int asociationId, String password) async {
    loading = true;

    Future<UserAsocResponse?>? userAsocData;

    try {
      userAsocData = userRepository.login(username, asociationId, password);
      // logger.i(userAsocData.toString());
      loading = false;
      return userAsocData;
    } catch (e) {
      EglHelper.toastMessage(e.toString());
      loading = false;
      return null;
    }
  }

  int setIdAsocAdmin(String profile, int asocId) {
    return session.setIdAsocAdmin(profile, asocId);
  }
}
