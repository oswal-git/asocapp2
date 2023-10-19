import 'package:asocapp/app/apirest/api_models/api_models.dart';
import 'package:asocapp/app/controllers/auth/login/login_controller.dart';
import 'package:asocapp/app/models/models.dart';
import 'package:asocapp/app/resources/resources.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/views/auth/change/change_page.dart';
import 'package:asocapp/app/views/auth/register/register_page.dart';
import 'package:asocapp/app/views/auth/retrieve/retrieve_page.dart';
import 'package:asocapp/app/views/dashboard/dashboard_page.dart';
import 'package:asocapp/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController loginController = Get.put(LoginController());
  BuildContext? _context;

  final Logger logger = Logger();

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//   }
// bNnK6te6

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          automaticallyImplyLeading: false,
          title: Text('tLogin'.tr),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  4.ph,
                  Text(
                    'tWelcom'.tr,
                    style: AppTheme.headline3,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'tWelcom2'.tr,
                    style: AppTheme.subtitle1.copyWith(height: 1.3),
                  ),
                  8.ph,
                  Form(
                    key: loginController.formKey,
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
    final double height = MediaQuery.of(context).size.height * 1;
    _context = context;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          EglAsociationsDropdown(
            labelText: 'lAsociation'.tr,
            hintText: 'hSelectAsociation'.tr,
            focusNode: loginController.asociationsFocusNode,
            future: loginController.refreshAsociationsList(),
            currentValue: loginController.userConnected!.idAsociationUser == 0 ? '' : loginController.userConnected!.idAsociationUser.toString(),
            onChanged: (onChangedVal) {
              loginController.userConnected!.idAsociationUser = int.parse(onChangedVal);
              logger.i('Asociation id: $onChangedVal');
              setState(() {});
            },
            onValidate: (onValidateVal) {
              if (onValidateVal == null) {
                return 'mSelectAsociation'.tr;
              }

              return null;
            },
          ),
          20.ph,
          EglInputTextField(
            focusNode: loginController.userNameFocusNode,
            nextFocusNode: loginController.passwordFocusNode,
            currentValue: '',
            iconLabel: Icons.person_pin,
            // ronudIconBorder: true,
            labelText: 'lUserName'.tr,
            hintText: 'hUserName'.tr,
            onChanged: (value) {
              loginController.userConnected!.userNameUser = value;

              logger.i('value: $value');
            },
            onValidator: (value) {
              return value!.isEmpty ? 'mInputUser'.tr : null;
            },
          ),
          SizedBox(height: height * .01),
          EglInputPasswordField(
            focusNode: loginController.passwordFocusNode,
            nextFocusNode: null,
            currentValue: '',
            iconLabel: Icons.key,
            ronudIconBorder: true,
            labelText: 'lPassword'.tr,
            onChanged: (value) {
              loginController.password = value;
              logger.i('value: $value');
            },
            onValidator: (value) {
              return value!.isEmpty ? 'mPassword'.tr : null;
            },
          ),
          SizedBox(height: height * .01),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Get.offAll(() => const RetrievePage());
              },
              child: Text(
                "${'mForgotPassword'.tr}?",
                style: AppTheme.headline2.copyWith(fontSize: 15, decoration: TextDecoration.underline),
              ),
            ),
          ),
          SizedBox(height: height * .01),
          EglRoundButton(
            title: 'bLogin'.tr,
            loading: loginController.loading,
            onPress: () async {
              if (loginController.formKey.currentState!.validate()) {
                UserAsocResponse? userAsocData = await loginController.login(
                  loginController.userConnected!.userNameUser,
                  loginController.userConnected!.idAsociationUser,
                  loginController.password,
                );
                if (userAsocData != null) {
                  if (userAsocData.status == 200) {
                    logger.i('user: ${userAsocData.result.toString()}');
                    loginController.updateUserConnected(UserConnected(
                      idUser: userAsocData.result!.dataUser.idUser,
                      idAsociationUser: userAsocData.result!.dataUser.idAsociationUser,
                      userNameUser: userAsocData.result!.dataUser.userNameUser,
                      emailUser: userAsocData.result!.dataUser.emailUser,
                      recoverPasswordUser: userAsocData.result!.dataUser.recoverPasswordUser,
                      tokenUser: userAsocData.result!.dataUser.tokenUser,
                      tokenExpUser: userAsocData.result!.dataUser.tokenExpUser,
                      profileUser: userAsocData.result!.dataUser.profileUser,
                      statusUser: userAsocData.result!.dataUser.statusUser,
                      nameUser: userAsocData.result!.dataUser.nameUser,
                      lastNameUser: userAsocData.result!.dataUser.lastNameUser,
                      avatarUser: userAsocData.result!.dataUser.avatarUser,
                      phoneUser: userAsocData.result!.dataUser.phoneUser,
                      dateDeletedUser: userAsocData.result!.dataUser.dateDeletedUser,
                      dateCreatedUser: userAsocData.result!.dataUser.dateCreatedUser,
                      dateUpdatedUser: userAsocData.result!.dataUser.dateUpdatedUser,
                      idAsocAdmin: loginController.setIdAsocAdmin(
                        userAsocData.result!.dataUser.profileUser,
                        userAsocData.result!.dataAsoc.idAsociation,
                      ),
                      longNameAsoc: userAsocData.result!.dataAsoc.longNameAsociation,
                      shortNameAsoc: userAsocData.result!.dataAsoc.shortNameAsociation,
                      timeNotificationsUser: userAsocData.result!.dataUser.timeNotificationsUser,
                      languageUser: userAsocData.result!.dataUser.languageUser,
                    ));

                    String language = userAsocData.result!.dataUser.languageUser;
                    String country = Helper.getAppCountryLocale(language);

                    var locale = Locale(language, country);
                    Get.updateLocale(locale);
                    Intl.defaultLocale = country == '' ? language : '${language}_$country';
                    if (userAsocData.result!.dataUser.recoverPasswordUser == 0) {
                      Get.offAll(() => const DashboardPage());
                    } else {
                      Get.offAll(() => const ChangePage());
                    }
                    // setState(() {});beLlsdkj
                    return;
                  }
                }
                Helper.popMessage(_context!, MessageType.info, 'No se ha encontrado el usuario', 'Usuario, asociación o clave erroneas');
              }
            },
          ),
          SizedBox(height: height * .01),
          InkWell(
            onTap: () {
              Get.offAll(() => const RegisterPage(), transition: Transition.downToUp);
            },
            child: Text.rich(
              TextSpan(text: '${'mNotAccount'.tr}  ', style: AppTheme.subtitle1.copyWith(fontSize: 15), children: [
                TextSpan(
                  text: 'mRegister'.tr,
                  style: AppTheme.headline2.copyWith(fontSize: 15, decoration: TextDecoration.underline),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
