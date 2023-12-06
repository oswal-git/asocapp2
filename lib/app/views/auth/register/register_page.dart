import 'package:asocapp/app/apirest/api_models/api_models.dart';
import 'package:asocapp/app/controllers/auth/register/register_controller.dart';
import 'package:asocapp/app/models/models.dart';
import 'package:asocapp/app/resources/resources.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/views/auth/login/login_page.dart';
import 'package:asocapp/app/views/auth/retrieve/retrieve_page.dart';
import 'package:asocapp/app/views/dashboard/dashboard_page.dart';
import 'package:asocapp/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterController registerController = Get.put<RegisterController>(RegisterController());

  final Logger logger = Logger();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    registerController.isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          automaticallyImplyLeading: false,
          title: const Text("Register User"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  4.ph,
                  Text(
                    "tWelcom".tr,
                    style: AppTheme.headline3,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'tWelcom3'.tr,
                    style: AppTheme.subtitle1.copyWith(height: 1.3),
                  ),
                  8.ph,
                  Form(
                    key: registerController.formKey,
                    child: _formUI(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _formUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          EglAsociationsDropdown(
            labelText: 'lAsociation'.tr,
            hintText: 'hSelectAsociation'.tr,
            focusNode: registerController.asociationsFocusNode,
            nextFocusNode: registerController.userNameFocusNode,
            future: registerController.refreshAsociationsList(),
            currentValue:
                registerController.userConnected!.idAsociationUser == 0 ? '' : registerController.userConnected!.idAsociationUser.toString(),
            onChanged: (onChangedVal) {
              registerController.idAsociationTextController.text = onChangedVal;
              logger.i('Asociation id: $onChangedVal');
            },
            onValidate: (onValidateVal) {
              if (onValidateVal == null) {
                return 'mPleaseSelectAsociation'.tr;
              }

              return null;
            },
          ),
          35.ph,
          // const EglInputLabelText(label: "User name", fontSize: 14),
          // 4.ph,
          EglInputTextField(
            focusNode: registerController.userNameFocusNode,
            nextFocusNode: registerController.passwordFocusNode,
            currentValue: '',
            iconLabel: Icons.person_pin,
            // ronudIconBorder: true,
            labelText: 'lUserName'.tr,
            hintText: 'hUserName'.tr,
            // icon: Icons.person_pin,
            onChanged: (value) {
              registerController.userNameTextController.text = value;
              logger.i('value: $value');
            },
            onValidator: (value) {
              if (value!.isEmpty) return 'Introduzca su nombre de usuario';
              if (value.length < 4) {
                return 'El nombre de usuario ha de tener 4 carácteres como mínimo ';
              }
              return null;
            },
          ),
          20.ph,
          EglInputPasswordField(
            focusNode: registerController.passwordFocusNode,
            nextFocusNode: registerController.questionFocusNode,
            currentValue: '',
            iconLabel: Icons.key,
            ronudIconBorder: true,
            labelText: 'lPassword'.tr,
            onChanged: (value) {
              registerController.passwordTextController.text = value;
              logger.i('value: $value');
            },
            onValidator: (value) {
              if (value!.isEmpty) return 'mPassword'.tr;
              if (value.length < 6) return 'mMinPassword'.tr;
              return null;
            },
          ),
          20.ph,
          EglInputMultiLineField(
            focusNode: registerController.questionFocusNode,
            nextFocusNode: registerController.answerFocusNode,
            currentValue: '',
            iconLabel: Icons.question_mark_outlined,
            ronudIconBorder: true,
            labelText: 'lQuestion'.tr,
            hintText: 'hQuestion'.tr,
            maxLength: 120,
            onChanged: (value) {
              registerController.questionTextController.text = value;
              logger.i('value: $value');
            },
            onValidator: (value) {
              return value!.isEmpty ? 'mQuestion'.tr : null;
            },
          ),
          20.ph,
          EglInputPasswordField(
            focusNode: registerController.answerFocusNode,
            nextFocusNode: null,
            currentValue: '',
            iconLabel: Icons.key,
            ronudIconBorder: true,
            labelText: 'lAnswerKey'.tr,
            onChanged: (value) {
              registerController.answerTextController.text = value;
              logger.i('value: $value');
            },
            onValidator: (value) {
              return value!.isEmpty ? 'mAnswerKey'.tr : null;
            },
          ),
          20.ph,
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Get.offAll(const RetrievePage());
              },
              child: Text(
                'mForgotPassword'.tr,
                style: AppTheme.headline2.copyWith(fontSize: 15, decoration: TextDecoration.underline),
              ),
            ),
          ),
          8.ph,
          EglRoundButton(
              title: 'tRegisterUser'.tr,
              loading: registerController.loading,
              onPress: () async {
                logger.d('tap');
                if (registerController.formKey.currentState!.validate() && int.parse(registerController.idAsociationTextController.text) != 0) {
                  HttpResult<UserAsocResponse>? httpResult = await registerController.registerGenericUser(
                    context,
                    registerController.userNameTextController.text,
                    int.parse(registerController.idAsociationTextController.text),
                    registerController.passwordTextController.text,
                    registerController.questionTextController.text,
                    registerController.answerTextController.text,
                  );
                  if (httpResult?.statusCode == 200) {
                    if (httpResult!.data != null) {
                      logger.i('userapp: ${httpResult.data.toString()}');
                      registerController.updateUserConnected(
                          UserConnected(
                            idUser: httpResult.data!.result!.dataUser.idUser,
                            idAsociationUser: httpResult.data!.result!.dataUser.idAsociationUser,
                            userNameUser: httpResult.data!.result!.dataUser.userNameUser,
                            emailUser: httpResult.data!.result!.dataUser.emailUser,
                            recoverPasswordUser: httpResult.data!.result!.dataUser.recoverPasswordUser,
                            tokenUser: httpResult.data!.result!.dataUser.tokenUser,
                            tokenExpUser: httpResult.data!.result!.dataUser.tokenExpUser,
                            profileUser: httpResult.data!.result!.dataUser.profileUser,
                            statusUser: httpResult.data!.result!.dataUser.statusUser,
                            nameUser: httpResult.data!.result!.dataUser.nameUser,
                            lastNameUser: httpResult.data!.result!.dataUser.lastNameUser,
                            avatarUser: httpResult.data!.result!.dataUser.avatarUser,
                            phoneUser: httpResult.data!.result!.dataUser.phoneUser,
                            dateDeletedUser: httpResult.data!.result!.dataUser.dateDeletedUser,
                            dateCreatedUser: httpResult.data!.result!.dataUser.dateCreatedUser,
                            dateUpdatedUser: httpResult.data!.result!.dataUser.dateUpdatedUser,
                            idAsocAdmin: registerController.setIdAsocAdmin(
                              httpResult.data!.result!.dataUser.profileUser,
                              httpResult.data!.result!.dataAsoc.idAsociation,
                            ),
                            longNameAsoc: httpResult.data!.result!.dataAsoc.longNameAsociation,
                            shortNameAsoc: httpResult.data!.result!.dataAsoc.shortNameAsociation,
                            timeNotificationsUser: httpResult.data!.result!.dataUser.timeNotificationsUser,
                            languageUser: httpResult.data!.result!.dataUser.languageUser,
                          ),
                          true);
                      Get.offAll(() => const DashboardPage());
                      return;
                    }
                    EglHelper.toastMessage('mCantRegister'.tr);
                  } else if (httpResult?.statusCode == 400) {
                    EglHelper.toastMessage(httpResult!.error!.data['message']);
                  } else {
                    EglHelper.toastMessage(httpResult!.error.toString());
                  }

                  registerController.loading = false;
                  return;
                  // answerTextController.text = '';
                }
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Get.offAll(() => const LoginPage());
                },
                child: Text.rich(
                  TextSpan(text: '${'mHaveAccount'.tr}?  ', style: AppTheme.subtitle1.copyWith(fontSize: 15), children: [
                    TextSpan(
                      text: 'tLogin'.tr,
                      style: AppTheme.headline2.copyWith(fontSize: 15, decoration: TextDecoration.underline),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
