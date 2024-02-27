import 'dart:async';

import 'package:asocapp/app/apirest/api_models/api_models.dart';
import 'package:asocapp/app/controllers/asociation/asociation_controller.dart';
import 'package:asocapp/app/models/models.dart';
import 'package:asocapp/app/repositorys/user_repository.dart';
import 'package:asocapp/app/services/services.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/views/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class RegisterController extends GetxController {
  final SessionService session = Get.put<SessionService>(SessionService());
  final AsociationController asociationController = Get.put(AsociationController());
  final UserRepository userRepository = Get.put(UserRepository());

  UserConnected? userConnected = UserConnected.clear();

  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: '_registerController');

  TextEditingController idAsociationTextController = TextEditingController();
  TextEditingController userNameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController questionTextController = TextEditingController();
  TextEditingController answerTextController = TextEditingController();

  final _answerFocusNode = FocusNode().obs;
  FocusNode get answerFocusNode => _answerFocusNode.value;

  final _asociationsFocusNode = FocusNode().obs;
  FocusNode get asociationsFocusNode => _asociationsFocusNode.value;

  final _userNameFocusNode = FocusNode().obs;
  FocusNode get userNameFocusNode => _userNameFocusNode.value;

  final _passwordFocusNode = FocusNode().obs;
  FocusNode get passwordFocusNode => _passwordFocusNode.value;

  final _questionFocusNode = FocusNode().obs;
  FocusNode get questionFocusNode => _questionFocusNode.value;

  final Logger logger = Logger();

  final _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;

  @override
  void onClose() {
    _answerFocusNode.value.dispose();
    _asociationsFocusNode.value.dispose();
    _passwordFocusNode.value.dispose();
    _questionFocusNode.value.dispose();
    _userNameFocusNode.value.dispose();

    idAsociationTextController.dispose();
    userNameTextController.dispose();
    passwordTextController.dispose();
    questionTextController.dispose();
    answerTextController.dispose();
    super.onClose();
  }

  Future<void> isLogin() async {
    if (session.isLogin) {
      // Timer(const Duration(seconds: 3), () => Navigator.pushNamed(context, RouteName.register));
      Timer(const Duration(seconds: 3), () => Get.offAll(() => const DashboardPage()));
    }
  }

  Future<List<dynamic>> refreshAsociationsList() async {
    return asociationController.refreshAsociationsList();
  }

  Future<HttpResult<UserAsocResponse>?> registerGenericUser(
      BuildContext context, String username, int asociationId, String password, String question, String answer) async {
    loading = true;

    try {
      loading = false;
      return userRepository.registerGenericUser(username, asociationId, password, question, answer);
    } catch (e) {
      EglHelper.toastMessage((e.toString()));
      loading = false;
      return null;
    }
  }

  Future<void> updateUserConnected(UserConnected value, bool loadTask) async {
    return session.updateUserConnected(value, loadTask: loadTask);
  }

  setIdAsocAdmin(String profile, int asocId) {
    return ['superadmin', 'admin'].contains(profile) ? asocId : 0;
  }
}
