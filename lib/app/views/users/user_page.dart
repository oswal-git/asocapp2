// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asocapp/app/controllers/users/user_item_controller.dart';
import 'package:asocapp/app/widgets/bar_widgets/egl_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:asocapp/app/apirest/api_models/api_models.dart';
import 'package:asocapp/app/resources/resources.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/widgets/widgets.dart';

class UserPage extends StatefulWidget {
  const UserPage({
    super.key,
    required this.user,
  });

  final UserItem user;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserItemController userItemController = Get.put<UserItemController>(UserItemController());

  BuildContext? _context;

  @override
  void dispose() {
    userItemController.userItem.value = userItemController.userItemLast.value.clone();

    super.dispose();
  }

  bool isOk = false;

  @override
  void initState() {
    super.initState();

    userItemController.isLogin(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EglAppBar(
        showBackArrow: true,
        title: 'tUserProfile'.tr,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                20.ph,
                widget.user.userNameUser == '' || widget.user.statusUser == ''
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
                        key: userItemController.formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction, // Habilita la validación cuando el usuario interactúa con el formulario
                        onChanged: () {},
                        child: _formUI(context, userItemController),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _formUI(BuildContext context, UserItemController userItemController) {
    List<dynamic> listUserStatus = UserStatus.getListUserStatus();
    List<dynamic> listUserProfiles = UserProfiles.getListUserProfiles();

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 250.0,
            height: 250.0,
            child: userItemController.userItem.value.avatarUser == ''
                ? const ClipOval(
                    child: Image(
                      image: AssetImage('assets/images/icons_user_profile_circle.png'),
                      //   fit: BoxFit.cover,
                      color: Colors.amberAccent,
                    ),
                  )
                : ClipOval(
                    child: Image.network(
                      userItemController.userItem.value.avatarUser,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          40.ph,
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [EglInputLabelText(label: "lAsociation".tr, fontSize: 14)]),
          3.ph,
          Text(
            userItemController.userItem.value.longNameAsociation,
            //   Utils.eglLogger('i', 'Asociation id: $onChangedVal');
          ),
          20.ph,
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [EglInputLabelText(label: "lUserName".tr, fontSize: 14)]),
          3.ph,
          Text(
            userItemController.userItem.value.userNameUser,
            //   Utils.eglLogger('i', 'Asociation id: $onChangedVal');
          ),
          20.ph,
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [EglInputLabelText(label: "lEmail".tr, fontSize: 14)]),
          3.ph,
          Text(
            userItemController.userItem.value.emailUser,
            //   Utils.eglLogger('i', 'Asociation id: $onChangedVal');
          ),
          20.ph,
          EglDropdownList(
            context: context,
            labelText: 'lProfile'.tr,
            hintText: 'hChooseProfile'.tr,
            contentPaddingLeft: 20,
            focusNode: userItemController.profileUserFocusNode,
            nextFocusNode: userItemController.statusUserFocusNode,
            lstData: listUserProfiles,
            value: userItemController.userItem.value.profileUser,
            // == 0
            //     ? '0'
            //     : userItemLast.timeNotificationsUser.toString(),
            onChanged: (onChangedVal) {
              userItemController.userItem.value.profileUser = onChangedVal;
              userItemController.checkIsFormValid();
            },
            onValidate: (onValidateVal) {
              if (onValidateVal == null) {
                return 'iSelectProfile'.tr;
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
            optionValue: "profile",
            optionLabel: "name",
            iconLabel: Icons.person,
          ),
          40.ph,
          EglDropdownList(
            context: context,
            labelText: 'lStatus'.tr,
            hintText: 'hChooseStatus'.tr,
            contentPaddingLeft: 20,
            focusNode: userItemController.statusUserFocusNode,
            nextFocusNode: null,
            lstData: listUserStatus,
            value: userItemController.userItem.value.statusUser,
            // == 0
            //     ? '0'
            //     : userItemLast.timeNotificationsUser.toString(),
            onChanged: (onChangedVal) {
              userItemController.userItem.value.statusUser = onChangedVal;

              //   Utils.eglLogger('w', 'timeNotifications: $onChangedVal');
              userItemController.checkIsFormValid();
            },
            onValidate: (onValidateVal) {
              if (onValidateVal == null) {
                return 'iSelectStatus'.tr;
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
            optionValue: "status",
            optionLabel: "name",
            iconLabel: Icons.watch_later_outlined,
          ),
          40.ph,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: userItemController.isFormValid
                ? EglRoundButton(
                    title: 'bProfile'.tr,
                    loading: userItemController.loading.value,
                    onPress: () async {
                      if (userItemController.formKey.currentState!.validate()) {
                        if (userItemController.userItem.value.profileUser != userItemController.userItemLast.value.profileUser ||
                            userItemController.userItem.value.statusUser != userItemController.userItemLast.value.statusUser) {
                          HttpResult<UserAsocResponse>? httpResult;
                          httpResult = await userItemController.updateProfileStatus(
                              userItemController.userItem.value.idUser,
                              userItemController.userItem.value.profileUser,
                              userItemController.userItem.value.statusUser,
                              userItemController.userItem.value.dateUpdatedUser);

                          if (httpResult!.statusCode == 200) {
                            if (httpResult.data != null) {
                              //   Utils.eglLogger('i', 'userapp: ${httpResult.data.toString()}');
                              userItemController.userItem.value.dateUpdatedUser = httpResult.data!.result!.dataUser.dateUpdatedUser;
                              userItemController.userItemLast.value = userItemController.userItem.value.copyWith();
                              userItemController.checkIsFormValid();

                              isOk = true;
                              //   Get.back();
                              Get.back(result: userItemController.userItem.value);
                              if (isOk) {}
                              //   navigator?.pop(userItemController.userItem.value);
                              return;
                            } else {
                              isOk = false;

                              EglHelper.toastMessage(httpResult.error.toString());
                              return;
                            }
                          } else if (httpResult.statusCode == 404) {
                            EglHelper.popMessage(_context!, MessageType.info, '${'mUnexpectedError'.tr}.', '${'mNoScriptAvailable'.tr}.');
                            EglHelper.eglLogger('e', httpResult.error?.data);
                            isOk = false;
                            return;
                          } else {
                            EglHelper.popMessage(
                                //   _context!, MessageType.info, 'Actualización no realizada', 'No se han podido actualizar los datos del usuario');
                                _context!,
                                MessageType.info,
                                '${'mNoUpdateProfile'.tr}.',
                                httpResult.error?.data);
                            isOk = false;
                            return;
                          }
                        } else {
                          EglHelper.popMessage(_context!, MessageType.info, 'No han habido cambios', 'Nada para modificar');
                          isOk = false;
                          return;
                          // Utils.eglLogger('i', 'EglRoundButton: userConnected: ${userItemController.userItem.value}');
                        }
                      } else {
                        EglHelper.popMessage(
                            context, MessageType.info, 'Faltan campos por rellenar', 'No se ha podido modificar el perfil del usuario');
                        isOk = false;
                        return;
                      }

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
    );
  }

  // *******
}
