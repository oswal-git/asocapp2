import 'dart:async';
import 'dart:io';

import 'package:asocapp/app/apirest/api_models/api_models.dart';
import 'package:asocapp/app/controllers/asociation/asociation_controller.dart';
import 'package:asocapp/app/models/models.dart';
import 'package:asocapp/app/repositorys/user_repository.dart';
import 'package:asocapp/app/services/session_service.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/views/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class ProfileController extends GetxController {
  final SessionService session = Get.put<SessionService>(SessionService());
  final AsociationController asociationController = Get.put(AsociationController());
  final UserRepository userRepository = Get.put(UserRepository());

  final Logger logger = Logger();

  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: '_profileController');

  final _asociationsFocusNode = FocusNode().obs;
  FocusNode get asociationsFocusNode => _asociationsFocusNode.value;

  final _userNameFocusNode = FocusNode().obs;
  FocusNode get userNameFocusNode => _userNameFocusNode.value;

  final _languageUserFocusNode = FocusNode().obs;
  FocusNode get languageUserFocusNode => _languageUserFocusNode.value;

  final _timeNotificationsFocusNode = FocusNode().obs;
  FocusNode get timeNotificationsFocusNode => _timeNotificationsFocusNode.value;

  Rx<UserConnected> userConnected = Rx<UserConnected>(UserConnected.clear());
  Rx<UserConnected> userConnectedIni = Rx<UserConnected>(UserConnected.clear());
  Rx<UserConnected> userConnectedLast = Rx<UserConnected>(UserConnected.clear());

  final loading = false.obs;

  final _isFormValid = false.obs;
  bool get isFormValid => _isFormValid.value;

  final _imageAvatar = Rx<XFile?>(XFile(''));
  XFile? get imageAvatar => _imageAvatar.value;
  set imageAvatar(XFile? value) => _imageAvatar.value = value;

  bool checkIsFormValid() {
    // logger.i('checkIsFormValid: ${_imageAvatar.value!.path}');
    // logger.i('checkIsFormValid: ${_imageAvatar.value!.path != ''}');
    return _isFormValid.value = ((formKey.currentState?.validate() ?? false) &&
        (userConnected.value.idAsociationUser != userConnectedLast.value.idAsociationUser ||
            userConnected.value.userNameUser != userConnectedLast.value.userNameUser ||
            userConnected.value.timeNotificationsUser != userConnectedLast.value.timeNotificationsUser ||
            (_imageAvatar.value == null ? false : _imageAvatar.value!.path != '') ||
            userConnected.value.languageUser != userConnectedLast.value.languageUser));
  }

  @override
  void onClose() {
    _asociationsFocusNode.value.dispose();
    _languageUserFocusNode.value.dispose();
    _timeNotificationsFocusNode.value.dispose();
    _userNameFocusNode.value.dispose();

//     idAsociationTextController.dispose();
//     userNameTextController.dispose();
//     passwordTextController.dispose();
//     questionTextController.dispose();
//     answerTextController.dispose();
//     super.onClose();
  }

  bool isLogin() {
    logger.i('isLogin: ');

    try {
      if (!session.isLogin) {
        // Timer(const Duration(seconds: 3), () => Navigator.pushNamed(context, RouteName.register));
        Get.to(DashboardPage);
        return false;
      }
      userConnected.value = session.userConnected.clone();
      userConnectedIni.value = userConnected.value.clone();
      userConnectedLast.value = userConnected.value.clone();
      logger.i('isLogin: ${userConnectedIni.value.idAsociationUser}');
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> refreshAsociationsList() async {
    return asociationController.refreshAsociationsList();
  }

  Future<void> clearAsociations() async {
    return asociationController.clearAsociations();
  }

  Future<HttpResult<UserAsocResponse>?> updateProfile(
    int idUser,
    String userName,
    int asociationId,
    int intervalNotifications,
    String languageUser,
    String dateUpdatedUser,
  ) async {
    loading.value = true;

    try {
      final Future<HttpResult<UserAsocResponse>?> response =
          userRepository.updateProfile(idUser, userName, asociationId, intervalNotifications, languageUser, dateUpdatedUser);
      loading.value = false;
      return response;
    } catch (e) {
      Helper.toastMessage(e.toString());
      loading.value = false;
      return null;
    }
  }

  Future<HttpResult<UserAsocResponse>?> updateProfileAvatar(
    int idUser,
    String userName,
    int asociationId,
    int intervalNotifications,
    String languageUser,
    XFile imageAvatar,
    String dateUpdatedUser,
  ) async {
    loading.value = true;

    try {
      final Future<HttpResult<UserAsocResponse>?> response =
          userRepository.updateProfileAvatar(idUser, userName, asociationId, intervalNotifications, languageUser, imageAvatar, dateUpdatedUser);
      loading.value = false;
      return response;
    } catch (e) {
      Helper.toastMessage(e.toString());
      loading.value = false;
      return null;
    }
  }

  Future<void> updateUserConnected(UserConnected value, bool loadTask) async {
    return session.updateUserConnected(value, loadTask: loadTask);
  }

  int setIdAsocAdmin(String profile, int asocId) {
    return session.setIdAsocAdmin(profile, asocId);
  }

  final _imageWidget = Rx<Widget>(
    const Image(
      image: AssetImage('assets/images/icons_user_profile_circle.png'),
      fit: BoxFit.scaleDown,
      color: Colors.amberAccent,
    ),
  );

  Widget get imageWidget => _imageWidget.value;
  setImageWidget(XFile? imagePick) {
    _imageAvatar.value = imagePick;
    // const double widthOval = 200.0;
    // const double heightOval = 200.0;

    if (imagePick == null) {
      // ignore: curly_braces_in_flow_control_structures
      if (userConnected.value.avatarUser == '') {
        _imageWidget.value = const ClipOval(
          child: Image(
            image: AssetImage('assets/images/icons_user_profile_circle.png'),
            //   fit: BoxFit.cover,
            color: Colors.amberAccent,
          ),
        );
      } else {
        _imageWidget.value = ClipOval(
          child: Image.network(
            userConnected.value.avatarUser,
            //   width: widthOval,
            //   height: heightOval,
            fit: BoxFit.cover,
          ),
        );
      }
    } else if (imagePick.path.substring(0, 4) == 'http') {
      _imageWidget.value = ClipOval(
        child: Image.network(
          imagePick.path,
          //   width: widthOval,
          //   height: heightOval,
          fit: BoxFit.cover,
        ),
      );
    } else {
      _imageWidget.value = ClipOval(
        child: Image.file(
          File(imagePick.path).absolute,
          //   width: widthOval,
          //   height: heightOval,
          fit: BoxFit.cover,
        ),
      );
    }
  }
}
