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

class UserItemController extends GetxController {
  final SessionService session = Get.put<SessionService>(SessionService());
  final AsociationController asociationController = Get.put(AsociationController());
  final UserRepository userRepository = Get.put(UserRepository());

  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: '_profileController');

  final _profileUserFocusNode = FocusNode().obs;
  FocusNode get profileUserFocusNode => _profileUserFocusNode.value;

  final _statusUserFocusNode = FocusNode().obs;
  FocusNode get statusUserFocusNode => _statusUserFocusNode.value;

  Rx<UserItem> userItem = Rx<UserItem>(UserItem.clear());
  Rx<UserItem> userItemIni = Rx<UserItem>(UserItem.clear());
  Rx<UserItem> userItemLast = Rx<UserItem>(UserItem.clear());

  final loading = false.obs;

  final _isFormValid = false.obs;
  bool get isFormValid => _isFormValid.value;

  bool checkIsFormValid() {
    // Helper.eglLogger('i','checkIsFormValid: ${_imageAvatar.value!.path}');
    // Helper.eglLogger('i','checkIsFormValid: ${_imageAvatar.value!.path != ''}');
    return _isFormValid.value = ((formKey.currentState?.validate() ?? false) &&
        (userItem.value.profileUser != userItemLast.value.profileUser || userItem.value.statusUser != userItemLast.value.statusUser));
  }

  @override
  void onClose() {
    _profileUserFocusNode.value.dispose();
    _statusUserFocusNode.value.dispose();

    super.onClose();
  }

  bool isLogin(UserItem user) {
    Helper.eglLogger('i', 'isLogin: ');

    try {
      if (!session.isLogin) {
        // Timer(const Duration(seconds: 3), () => Navigator.pushNamed(context, RouteName.register));
        Get.to(() => DashboardPage);
        return false;
      }
      userItem.value = user.clone();
      userItemIni.value = user.clone();
      userItemLast.value = user.clone();
      Helper.eglLogger('i', 'isLogin: ${userItemIni.value.idAsociationUser}');
      return true;
    } catch (e) {
      rethrow;
    }
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

  Future<HttpResult<UserAsocResponse>?> updateProfileStatus(int idUser, String profileUser, String statusUser, String dateUpdatedUser) async {
    loading.value = true;

    try {
      final Future<HttpResult<UserAsocResponse>?> response = userRepository.updateProfileStatus(idUser, profileUser, statusUser, dateUpdatedUser);
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
}
