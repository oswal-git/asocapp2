import 'dart:async';

import 'package:asocapp/app/apirest/api_models/api_models.dart';
import 'package:asocapp/app/controllers/asociation/asociation_controller.dart';
import 'package:asocapp/app/models/models.dart';
import 'package:asocapp/app/repositorys/user_repository.dart';
import 'package:asocapp/app/services/session_service.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/views/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class RetrieveController extends GetxController {
  final SessionService session = Get.put<SessionService>(SessionService());
  final AsociationController asociationController = Get.put(AsociationController());
  final UserRepository userRepository = Get.put(UserRepository());

  final UserConnected? userConnected = UserConnected.clear();

  List<dynamic> get asociationsList => asociationController.asociationsList;

  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: '_retrieveController');

  TextEditingController emailTextController = TextEditingController();
  TextEditingController idAsociationTextController = TextEditingController();
  TextEditingController userNameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController questionTextController = TextEditingController();
  TextEditingController answerTextController = TextEditingController();

  final _answerFocusNode = FocusNode().obs;
  FocusNode get answerFocusNode => _answerFocusNode.value;

  final _asociationsFocusNode = FocusNode().obs;
  FocusNode get asociationsFocusNode => _asociationsFocusNode.value;

  final _emailFocusNode = FocusNode().obs;
  FocusNode get emailFocusNode => _emailFocusNode.value;

  final _passwordFocusNode = FocusNode().obs;
  FocusNode get passwordFocusNode => _passwordFocusNode.value;

  final _questionFocusNode = FocusNode().obs;
  FocusNode get questionFocusNode => _questionFocusNode.value;

  final _userNameFocusNode = FocusNode().obs;
  FocusNode get userNameFocusNode => _userNameFocusNode.value;

  final Logger logger = Logger();

  final loading = false.obs;

  final _questionList = Rx<QuestionList>(QuestionList.clear());
  QuestionList get questionList => _questionList.value;
  set questionList(value) => _questionList.value = value;

  final _selectedOption = false.obs;
  bool get selectedOption => _selectedOption.value;
  set selectedOption(value) => _selectedOption.value = value;

  final _showClave = false.obs;
  bool get showClave => _showClave.value;
  set showClave(value) => _showClave.value = value;

  final _showAlterEmail = false.obs;
  bool get showAlterEmail => _showAlterEmail.value;
  set showAlterEmail(value) => _showAlterEmail.value = value;

  @override
  onInit() {
    super.onInit();
    Helper.eglLogger('i', '$runtimeType');
  }

  @override
  void onClose() {
    _answerFocusNode.value.dispose();
    _asociationsFocusNode.value.dispose();
    _emailFocusNode.value.dispose();
    _passwordFocusNode.value.dispose();
    _questionFocusNode.value.dispose();
    _userNameFocusNode.value.dispose();

    answerTextController.dispose();
    emailTextController.dispose();
    idAsociationTextController.dispose();
    passwordTextController.dispose();
    questionTextController.dispose();
    userNameTextController.dispose();
    Helper.eglLogger('i', '$runtimeType');
    super.onClose();
  }

  Future<void> isLogin(context) async {
    if (!session.isLogin) {
      // Timer(const Duration(seconds: 3), () => Navigator.pushNamed(context, RouteName.register));
      Timer(const Duration(seconds: 3), () => Get.to(() => DashboardPage));
    }
  }

  Future<List<dynamic>> refreshAsociationsList() async {
    return asociationController.refreshAsociationsList();
  }

  Future<QuestionList> retrieveQuestion(BuildContext context, String username, int asociationId) async {
    Helper.toastMessage('Data save successfully: $username from ${asociationId.toString()}');
    loading.value = true;
    QuestionList questionList = QuestionList.clear();

    void fillQuestion(List<QuestionListUser> value) {
      value
          .map((item) => {
                questionList.questions.add({'option': item.questionUser, 'texto': item.questionUser, 'icon': Icons.question_mark}),
              })
          .toList();
    }

    try {
      QuestionListUserResponse? questionListUserResponse = await userRepository.retrieveQuestion(username, asociationId);

      // print('Response body: ${result}');
      if (questionListUserResponse != null && questionListUserResponse.status == 200) {
        if (questionListUserResponse.result.numRecords == 0) {
          Helper.toastMessage('No se ha encontrado el usuario');
          loading.value = false;
          questionList.showClave = false;
          questionList.status = 'No se ha encontrado el usuario';
          return questionList;
        } else if (questionListUserResponse.result.numRecords == 1) {
          questionList.question = questionListUserResponse.result.records[0].questionUser;
          loading.value = false;
          questionList.showClave = true;
          questionList.status = 'ok';
          return questionList;
        } else {
          questionList.question = questionListUserResponse.result.records[0].questionUser;
          fillQuestion(questionListUserResponse.result.records);
          loading.value = false;
          questionList.showClave = false;
          questionList.status = 'ok';
          return questionList;
        }
      }

      logger.i('Non data: $username from ${asociationId.toString()}');
      loading.value = false;
      questionList.status = 'No hay datos';
      return questionList;
      // ignore: use_build_context_synchronously
      // Navigator.pushNamed(context, RouteName.dashboard);
    } catch (e) {
      Helper.toastMessage(e.toString());

      loading.value = false;
      questionList.status = 'e.toString()';
      return questionList;
    }
  }

  Future<HttpResult<UserPassResponse>?> validateKey(BuildContext context, String username, int asociationId, String question, String answer) async {
    loading.value = true;

    Future<HttpResult<UserPassResponse>?>? userPassResponse;

    try {
      userPassResponse = userRepository.validateKey(username, asociationId, question, answer);
      logger.i(userPassResponse.toString());
      loading.value = false;
      return userPassResponse;
    } catch (e) {
      Helper.toastMessage(e.toString());
      loading.value = false;
      return null;
    }
  }

  Future<HttpResult<UserResetResponse>?> reset(BuildContext context, String email) async {
    loading.value = true;

    Future<HttpResult<UserResetResponse>?>? userResetResponse = Future.value(HttpResult<UserResetResponse>(
      data: null,
      error: HttpError(
        data: 'message',
        exception: null,
        stackTrace: StackTrace.current,
      ),
      statusCode: 200,
    ));

    try {
      userResetResponse = userRepository.reset(email);
      logger.i(userResetResponse.toString());
      loading.value = false;
      return userResetResponse;
    } catch (e) {
      Helper.toastMessage(e.toString());
      loading.value = false;
      return null;
    }
  }
}
