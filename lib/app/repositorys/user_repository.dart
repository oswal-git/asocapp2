import 'package:asocapp/app/apirest/api_models/api_models.dart';
import 'package:asocapp/app/apirest/network/network.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserRepository {
  AuthApiRest authApiRest = Get.put(AuthApiRest());
  UserApiRest userApiRest = Get.put(UserApiRest());

  Future<HttpResult<UserAsocResponse>?> registerGenericUser(
      String username, int asociationId, String password, String question, String answer) async {
    return authApiRest.registerGenericUser(username, asociationId, password, question, answer);
  }

  // Retrieve querys from user
  Future<QuestionListUserResponse?>? retrieveQuestion(String username, int asociationId) async {
    return await userApiRest.getAllQuestionByUsernameAndAsociationId(username, asociationId);
  }

  // validate answer for question
  Future<HttpResult<UserPassResponse>?> validateKey(String username, int asociationId, String question, String key) async {
    return userApiRest.validateKey(username, asociationId, question, key);
  }

  // Reset password
  Future<HttpResult<UserResetResponse>?> reset(String email) async {
    return authApiRest.reset(email);
  }

  // Login user
  Future<UserAsocResponse?>? login(String username, int asociationId, String password) async {
    return authApiRest.login(username, asociationId, password);
  }

// Change password
  Future<UserAsocResponse?>? change(String username, int asociationId, String password, String newPassword) async {
    return authApiRest.change(username, asociationId, password, newPassword);
  }

  Future<HttpResult<UserAsocResponse>?> updateProfile(
      int idUser, String userName, int asociationId, int intervalNotifications, String languageUser, String dateUpdatedUser) async {
    return userApiRest.updateProfile(idUser, userName, asociationId, intervalNotifications, languageUser, dateUpdatedUser);
  }

  Future<HttpResult<UserAsocResponse>?> updateProfileAvatar(int idUser, String userName, int asociationId, int intervalNotifications,
      String languageUser, XFile imageAvatar, String dateUpdatedUser) async {
    return userApiRest.updateProfileAvatar(idUser, userName, asociationId, intervalNotifications, languageUser, imageAvatar, dateUpdatedUser);
  }
}
