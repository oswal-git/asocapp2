import 'package:asocapp/app/apirest/api_models/api_models.dart';
import 'package:asocapp/app/controllers/auth/change/change_controller.dart';
import 'package:asocapp/app/models/models.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/views/auth/login/login_page.dart';
import 'package:asocapp/app/widgets/bar_widgets/egl_appbar.dart';
import 'package:asocapp/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ChangePage extends StatefulWidget {
  const ChangePage({
    super.key,
  });

  @override
  State<ChangePage> createState() => _ChangePageState();
}

class _ChangePageState extends State<ChangePage> {
  BuildContext? _context;
  ChangeController changeController = Get.put<ChangeController>(ChangeController());

  final Logger logger = Logger();

  @override
  void initState() {
    super.initState();

    changeController.isLogin();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(changeController.passwordFocusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    const String title = 'Cambio de contraseña';

    return Scaffold(
      // drawer: const NavBar(),
      appBar: EglAppBar(
        showBackArrow: true,
        title: title,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout_outlined), // Icono para la acción a la derecha
            onPressed: () {
              changeController.exitSession();
              Get.offAll(() => const LoginPage());
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                4.ph,
                Form(
                  key: changeController.formKey,
                  child: _formUI(context),
                ),
              ],
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
            focusNode: null,
            nextFocusNode: null,
            future: changeController.refreshAsociationsList(),
            currentValue: changeController.userConnected!.idAsociationUser == 0 ? '' : changeController.userConnected!.idAsociationUser.toString(),
            onChanged: null,
            onValidate: (onValidateVal) {
              if (onValidateVal == null) {
                return 'Please Select Asociation';
              }

              return null;
            },
          ),
          20.ph,
          EglInputTextField(
            focusNode: null,
            nextFocusNode: null,
            currentValue: changeController.userConnected!.userNameUser, //userNameTextController.text,
            iconLabel: Icons.person_pin,
            // ronudIconBorder: true,
            labelText: 'User alias',
            hintText: 'Alias del usuario',
            readOnly: true,
            onChanged: null,
            onValidator: (value) {
              return value!.isEmpty ? 'Introduzca su nombre de usuario' : null;
            },
          ),
          SizedBox(height: height * .01),
          EglInputPasswordField(
            focusNode: changeController.passwordFocusNode,
            nextFocusNode: changeController.newPasswordFocusNode,
            currentValue: '',
            iconLabel: Icons.key,
            ronudIconBorder: true,
            labelText: 'Contraseña',
            onChanged: (value) {
              changeController.passwordTextController.text = value;
              logger.i('value: $value');
            },
            onValidator: (value) {
              return value!.isEmpty ? 'Introduzca la contraseña' : null;
            },
          ),
          SizedBox(height: height * .01),
          EglInputPasswordField(
            focusNode: changeController.newPasswordFocusNode,
            nextFocusNode: null,
            currentValue: '',
            iconLabel: Icons.key,
            ronudIconBorder: true,
            labelText: 'Nueva Contraseña',
            onChanged: (value) {
              changeController.newPasswordTextController.text = value;
              logger.i('value: $value');
            },
            onValidator: (value) {
              return value!.isEmpty ? 'Introduzca la contraseña nueva' : null;
            },
          ),
          SizedBox(height: height * .01),
          SizedBox(height: height * .01),
          EglRoundButton(
            title: 'Cambiar',
            loading: changeController.loading,
            onPress: () async {
              if (changeController.formKey.currentState!.validate()) {
                changeController.loading = true;
                UserAsocResponse? userAsocData = await changeController.change(
                  context,
                  changeController.userConnected!.userNameUser,
                  changeController.userConnected!.idAsociationUser,
                  changeController.passwordTextController.text,
                  changeController.newPasswordTextController.text,
                );
                if (userAsocData?.status == 200) {
                  if (userAsocData != null) {
                    logger.i('user: ${userAsocData.result.toString()}');
                    changeController.updateUserConnected(UserConnected(
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
                      idAsocAdmin: userAsocData.result!.dataAsoc.idAsociation,
                      longNameAsoc: userAsocData.result!.dataAsoc.longNameAsociation,
                      shortNameAsoc: userAsocData.result!.dataAsoc.shortNameAsociation,
                      timeNotificationsUser: userAsocData.result!.dataUser.timeNotificationsUser,
                      languageUser: userAsocData.result!.dataUser.languageUser,
                    ));

                    changeController.exitSession();
                    Get.offAll(() => const LoginPage());
                    // Get.offAll(() => const DashboardPage());
                    // setState(() {});
                    return;
                  }
                  EglHelper.popMessage(_context!, MessageType.info, 'No se ha encontrado el usuario', 'Usuario, asociación o clave erroneas');
                } else if (userAsocData?.status == 400) {
                  EglHelper.toastMessage(userAsocData!.message);
                } else {
                  EglHelper.toastMessage(userAsocData!.message);
                }
                changeController.loading = false;
                return;
              }
            },
          ),
          SizedBox(height: height * .01),
        ],
      ),
    );
  }
}
