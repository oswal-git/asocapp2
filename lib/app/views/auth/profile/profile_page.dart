import 'package:asocapp/app/apirest/api_models/api_models.dart';
import 'package:asocapp/app/controllers/auth/profile/profile_controller.dart';
import 'package:asocapp/app/models/models.dart';
import 'package:asocapp/app/translations/language_model.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/widgets/widgets.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileController profileController = Get.put<ProfileController>(ProfileController());

  BuildContext? _context;

  @override
  void dispose() {
    profileController.clearAsociations();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    profileController.isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: true,
        title: Text('tUserProfile'.tr),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                20.ph,
                profileController.userConnectedLast.value.userNameUser == '' || profileController.userConnectedLast.value.timeNotificationsUser == 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          200.ph,
                          const Center(
                            child: CircularProgressIndicator(
                              strokeAlign: 5,
                            ),
                          ),
                        ],
                      )
                    : Form(
                        key: profileController.formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction, // Habilita la validación cuando el usuario interactúa con el formulario
                        onChanged: () {},
                        child: _formUI(context, profileController),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _formUI(BuildContext context, ProfileController profileController) {
    _context = context;

    List<dynamic> listTimes = [
      {
        'id': 99,
        'name': 'cDontNotify'.tr,
      },
      {
        'id': 1,
        'name': 'cEachHour'.tr,
      },
      {
        'id': 6,
        'name': 'cEachSixHours'.tr,
      },
      {
        'id': 12,
        'name': 'cTwiceDaily'.tr,
      },
      {
        'id': 24,
        'name': 'cOnceADay'.tr,
      },
    ];

    List<dynamic> listLanguages = Language.getLanguageList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            EglAsociationsDropdown(
              labelText: 'lAsociation'.tr,
              hintText: 'hSelectAsociation'.tr,
              focusNode: profileController.asociationsFocusNode,
              future: profileController.refreshAsociationsList(),
              currentValue: profileController.userConnected.value.idAsociationUser == 0
                  ? ''
                  : profileController.userConnected.value.idAsociationUser.toString(),
              onChanged: (onChangedVal) {
                profileController.userConnected.value.idAsociationUser = int.parse(onChangedVal);
                //   Utils.eglLogger('i', 'Asociation id: $onChangedVal');
                profileController.checkIsFormValid();
              },
              onValidate: (onValidateVal) {
                if (onValidateVal == null) {
                  return 'Please Select Asociation';
                }

                return null;
              },
            ),
            20.ph,
            // const EglInputLabelText(label: "User name", fontSize: 14),
            20.ph,
            EglInputTextField(
              focusNode: profileController.userNameFocusNode,
              nextFocusNode: profileController.timeNotificationsFocusNode,
              currentValue: profileController.userConnected.value.userNameUser,
              iconLabel: Icons.person_pin,
              // ronudIconBorder: true,
              labelText: 'lUserName'.tr,
              hintText: 'hUserName'.tr,
              // icon: Icons.person_pin,
              onChanged: (value) {
                profileController.userConnected.value.userNameUser = value;
                profileController.checkIsFormValid();
              },
              onValidator: (value) {
                if (value!.isEmpty) return 'Introduzca su nombre de usuario';
                if (value.length < 4) return 'El nombre de usuario ha de tener 4 carácteres como mínimo ';
                return null;
              },
            ),
            20.ph,
            EglDropdownList(
              context: context,
              labelText: 'lLanguage'.tr,
              hintText: 'hChooseLanguage'.tr,
              contentPaddingLeft: 20,
              focusNode: profileController.languageUserFocusNode,
              nextFocusNode: null,
              lstData: listLanguages,
              value: profileController.userConnectedLast.value.languageUser,
              // == 0
              //     ? '0'
              //     : userConnectedLast.timeNotificationsUser.toString(),
              onChanged: (onChangedVal) {
                profileController.userConnected.value.languageUser = onChangedVal;
                profileController.checkIsFormValid();
              },
              onValidate: (onValidateVal) {
                if (onValidateVal == null) {
                  return 'iSelectIdioma'.tr;
                }
                return null;
              },
              borderFocusColor: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
              paddingTop: 0,
              paddingLeft: 0,
              paddingRight: 0,
              paddingBottom: 0,
              borderRadius: 10,
              optionValue: "id",
              optionLabel: "name",
              iconLabel: Icons.language_outlined,
            ),
            40.ph,
            EglDropdownList(
              context: context,
              labelText: 'lIntervalNotification'.tr,
              hintText: 'hIntIntervalNotification'.tr,
              contentPaddingLeft: 20,
              focusNode: profileController.timeNotificationsFocusNode,
              nextFocusNode: null,
              lstData: listTimes,
              value: profileController.userConnectedLast.value.timeNotificationsUser.toString(),
              // == 0
              //     ? '0'
              //     : userConnectedLast.timeNotificationsUser.toString(),
              onChanged: (onChangedVal) {
                profileController.userConnected.value.timeNotificationsUser = int.parse(onChangedVal);

                //   Utils.eglLogger('w', 'timeNotifications: $onChangedVal');
                profileController.checkIsFormValid();
              },
              onValidate: (onValidateVal) {
                if (onValidateVal == null) {
                  return 'Please Select Interval';
                }

                return null;
              },
              borderFocusColor: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
              paddingTop: 0,
              paddingLeft: 0,
              paddingRight: 0,
              paddingBottom: 0,
              borderRadius: 10,
              optionValue: "id",
              optionLabel: "name",
              iconLabel: Icons.watch_later_outlined,
            ),
            40.ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: profileController.isFormValid
                  ? EglRoundButton(
                      title: 'bProfile'.tr,
                      loading: profileController.loading.value,
                      onPress: () async {
                        if (profileController.formKey.currentState!.validate()) {
                          if (profileController.userConnected.value.idAsociationUser != profileController.userConnectedLast.value.idAsociationUser ||
                              profileController.userConnected.value.userNameUser != profileController.userConnectedLast.value.userNameUser ||
                              profileController.userConnected.value.timeNotificationsUser !=
                                  profileController.userConnectedLast.value.timeNotificationsUser ||
                              profileController.userConnected.value.languageUser != profileController.userConnectedLast.value.languageUser) {
                            HttpResult<UserAsocResponse>? httpResult = await profileController.updateProfile(
                                profileController.userConnected.value.idUser,
                                profileController.userConnected.value.userNameUser,
                                profileController.userConnected.value.idAsociationUser,
                                profileController.userConnected.value.timeNotificationsUser,
                                profileController.userConnected.value.languageUser,
                                profileController.userConnected.value.dateUpdatedUser);
                            if (httpResult!.data != null) {
                              if (httpResult.statusCode == 200) {
                                //   Utils.eglLogger('i', 'userapp: ${httpResult.data.toString()}');
                                final UserConnected userConnected = UserConnected(
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
                                  idAsocAdmin: profileController.setIdAsocAdmin(
                                    httpResult.data!.result!.dataUser.profileUser,
                                    httpResult.data!.result!.dataAsoc.idAsociation,
                                  ),
                                  longNameAsoc: httpResult.data!.result!.dataAsoc.longNameAsociation,
                                  shortNameAsoc: httpResult.data!.result!.dataAsoc.shortNameAsociation,
                                  timeNotificationsUser: httpResult.data!.result!.dataUser.timeNotificationsUser,
                                  languageUser: httpResult.data!.result!.dataUser.languageUser,
                                );

                                await profileController.updateUserConnected(
                                  userConnected,
                                  profileController.userConnected.value.timeNotificationsUser !=
                                      profileController.userConnectedLast.value.timeNotificationsUser,
                                );

                                //   AppLocale locale = Utils.getAppLocale(httpResult.data!.result!.dataUser.languageUser);
                                String language = profileController.userConnected.value.languageUser;
                                String country = Helper.getAppCountryLocale(language);

                                var locale = Locale(language, country);
                                Get.updateLocale(locale);
                                Intl.defaultLocale = country == '' ? language : '${language}_$country';
                                // userConnectedIni = profileController.userConnected.value.clone();
                                profileController.userConnectedLast.value = profileController.userConnected.value.clone();

                                Helper.popMessage(
                                    _context!, MessageType.info, 'Usuario actualizado', profileController.userConnected.value.userNameUser);
                                //   'EglRoundButton: userConnected: ${profileController.userConnected.value}');
                                //   Navigator.pushNamed(_context!, RouteName.dashboard);
                                // setState(() {});
                                return;
                              } else {
                                Helper.toastMessage(httpResult.error.toString());
                                return;
                              }
                            }
                            Helper.popMessage(
                                //   _context!, MessageType.info, 'Actualización no realizada', 'No se han podido actualizar los datos del usuario');
                                _context!,
                                MessageType.info,
                                'Actualización no realizada',
                                httpResult.error?.data);
                            return;
                          } else {
                            Helper.popMessage(_context!, MessageType.info, 'No han habido cambios', 'Nada para modificar');
                            return;
                            // Utils.eglLogger('i', 'EglRoundButton: userConnected: ${profileController.userConnected.value}');
                          }
                        }
                        Helper.popMessage(context, MessageType.info, 'Faltan campos por rellenar', 'No se ha podido modificar el perfil del usuario');
                        //   Helper.toastMessage(title: 'Error al modificar el perfil', content: const Text('No se ha podido modificar el perfil del usuario'));
                      },
                    )
                  : const SizedBox(
                      height: 50,
                      width: double.infinity,
                    ),
            ),
          ],
        ),
      ),

      //   hasta aqui
    );
  }
}
