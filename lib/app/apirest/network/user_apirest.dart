import 'dart:convert';

import 'package:asocapp/app/apirest/network/network.dart';
import 'package:asocapp/app/apirest/response/response.dart';
import 'package:asocapp/app/apirest/utils/utils.dart';
import 'package:asocapp/app/config/config.dart';
import 'package:asocapp/app/services/session_service.dart';
import 'package:asocapp/app/utils/helper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:logger/logger.dart';

import '../api_models/api_models.dart';

class UserApiRest {
  final SessionService session = Get.put<SessionService>(SessionService());
  final ApiClient apiClient = ApiClient();

  final String apiUser = 'users';
  final Logger logger = Logger();

  Future<QuestionListUserResponse?> getAllQuestionByUsernameAndAsociationId(String username, int asociationId) async {
    // Map<String, String> requestHeaders = {
    //   'Content-type': 'application/json',
    // };

    final url = await EglConfig.uri(apiUser, '${EglConfig.apiListAllQuestions}?user_name_user=$username&id_asociation_user=$asociationId');

    final response = await apiClient.get(url);

    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      final QuestionListUserResponse questionListUserResponse = questionListUserResponseFromJson(await ApiResponse.returnResponse(response));

      // print('Asociations Response body: ${asociationsResponse.result.records}');
      return questionListUserResponse;
    }

    return null;
  }

  Future<HttpResult<UserPassResponse>?> validateKey(String username, int asociationId, String question, String key) async {
    int? statusCode;
    dynamic data;

    // Map<String, String> requestHeaders = {
    //   'Content-type': 'lication/json',
    // };

    final body = jsonEncode({
      'user_name_user': username,
      'id_asociation_user': asociationId,
      'question_user': question,
      'answer_user': key,
    });

    logger.i('answer_user: $key');

    final url = await EglConfig.uri(apiUser, EglConfig.apiValidateKey);

    try {
      final response = await apiClient.post(url, body);

      statusCode = response.statusCode;

      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final UserPassResponse userPassResponse = userPassResponseFromJson(await EglHelper.parseApiUrlBody(response.body));

        // print('Asociations Response body: ${asociationsResponse.result.records}');
        // return userPassResponse;
        return HttpResult<UserPassResponse>(
          data: userPassResponse,
          statusCode: statusCode,
          error: null,
        );
      } else if (statusCode > 400) {
        data = parseResponseBody(await EglHelper.parseApiUrlBody(response.body));
        return HttpResult<UserPassResponse>(
          data: null,
          error: HttpError(
            data: data,
            exception: null,
            stackTrace: StackTrace.current,
          ),
          statusCode: statusCode,
        );
      } else {
        data = parseResponseBody(await EglHelper.parseApiUrlBody(response.body));
        String message = data['message'];
        return HttpResult<UserPassResponse>(
          data: null,
          error: HttpError(
            data: message,
            exception: null,
            stackTrace: StackTrace.current,
          ),
          statusCode: statusCode,
        );
      }
    } catch (e, s) {
      if (e is HttpError) {
        return HttpResult<UserPassResponse>(
          data: null,
          error: e,
          statusCode: statusCode!,
        );
      }

      return HttpResult<UserPassResponse>(
        data: null,
        error: HttpError(
          exception: e,
          stackTrace: s,
          data: data,
        ),
        statusCode: statusCode ?? -1,
      );
    }

    // return null;
  }

  Future<HttpResult<UserAsocResponse>?> updateProfileAvatar(int idUser, String userName, int asociationId, int intervalNotifications,
      String languageUser, XFile imageAvatar, String dateUpdatedUser) async {
    Map<String, String> requestHeaders;
    Map<String, dynamic> fields;
    List<http.MultipartFile> files = [];

    int? statusCode;
    dynamic data;

    var stream = http.ByteStream(imageAvatar.openRead());
    stream.cast();

    // var stream = imageAvatar.readAsBytes().asStream();

    var len = await imageAvatar.length();

    final url = await EglConfig.uri(apiUser, EglConfig.apiUserProfileAvatar);

    //add headers
    requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${session.getAuthToken}',
    };

    fields = {
      'id_user': idUser.toString(),
      'user_name_user': userName,
      'id_asociation_user': asociationId.toString(),
      'time_notifications_user': intervalNotifications.toString(),
      'language_user': languageUser,
      'date_updated_user': dateUpdatedUser,
      'action': 'profile',
      'module': 'users',
      'prefix': 'avatars/user-$idUser',
      'date_updated': dateUpdatedUser,
      'token': session.getAuthToken,
      'user_name': userName,
      'name': '$userName.png',
      'cover': '',
    };

    http.MultipartFile multiport = http.MultipartFile('file', stream, len, filename: '$userName.png');

    files.add(multiport);

    try {
      final response = await apiClient.sendMultipartRequest(
        url: url,
        endpoint: 'upload',
        headers: requestHeaders,
        fields: fields,
        files: files,
      );

      statusCode = response.statusCode;

      if (response.statusCode == 200) {
        final UserAsocResponse userAsocResponse = userAsocResponseFromJson(await EglHelper.parseApiUrlBody(response.body));

        // print('Asociations Response body: ${asociationsResponse.result.records}');
        // return userAsocResponse;
        return HttpResult<UserAsocResponse>(
          data: userAsocResponse,
          statusCode: statusCode,
          error: null,
        );
      } else if (statusCode > 400) {
        data = parseResponseBody(await EglHelper.parseApiUrlBody(response.body));
        return HttpResult<UserAsocResponse>(
          data: null,
          error: HttpError(
            data: data,
            exception: null,
            stackTrace: StackTrace.current,
          ),
          statusCode: statusCode,
        );
      } else {
        data = parseResponseBody(await EglHelper.parseApiUrlBody(response.body));
        String message = data['message'];
        return HttpResult<UserAsocResponse>(
          data: null,
          error: HttpError(
            data: message,
            exception: null,
            stackTrace: StackTrace.current,
          ),
          statusCode: statusCode,
        );
      }

      // return null;
    } catch (e, s) {
      if (e is HttpError) {
        return HttpResult<UserAsocResponse>(
          data: null,
          error: e,
          statusCode: statusCode!,
        );
      }

      return HttpResult<UserAsocResponse>(
        data: null,
        error: HttpError(
          exception: e,
          stackTrace: s,
          data: 'Error inesperado.',
        ),
        statusCode: statusCode ?? -1,
      );
    }
  }

  Future<HttpResult<UserAsocResponse>?> updateProfile(
      int idUser, String userName, int asociationId, int intervalNotifications, String languageUser, String dateUpdatedUser) async {
    int? statusCode;
    dynamic data;

    final body = jsonEncode({
      'id_user': idUser,
      'user_name_user': userName,
      'id_asociation_user': asociationId,
      'time_notifications_user': intervalNotifications,
      'language_user': languageUser,
      'date_updated_user': dateUpdatedUser,
    });

    final url = await EglConfig.uri(apiUser, EglConfig.apiUserProfile);

    try {
      final response = await apiClient.post(url, body, token: '${session.getAuthToken}');

      EglHelper.eglLogger('i', 'Asociations Response body: ${response.body}');
      statusCode = response.statusCode;

      if (response.statusCode == 200) {
        final UserAsocResponse userAsocResponse = userAsocResponseFromJson(await EglHelper.parseApiUrlBody(response.body));

        // return userAsocResponse;
        return HttpResult<UserAsocResponse>(
          data: userAsocResponse,
          statusCode: statusCode,
          error: null,
        );
      } else if (statusCode > 400) {
        data = parseResponseBody(await EglHelper.parseApiUrlBody(response.body));
        return HttpResult<UserAsocResponse>(
          data: null,
          error: HttpError(
            data: data,
            exception: null,
            stackTrace: StackTrace.current,
          ),
          statusCode: statusCode,
        );
      } else {
        data = parseResponseBody(await EglHelper.parseApiUrlBody(response.body));
        String message = data['message'];
        return HttpResult<UserAsocResponse>(
          data: null,
          error: HttpError(
            data: message,
            exception: null,
            stackTrace: StackTrace.current,
          ),
          statusCode: statusCode,
        );
      }

      // return null;
    } catch (e, s) {
      if (e is HttpError) {
        return HttpResult<UserAsocResponse>(
          data: null,
          error: e,
          statusCode: statusCode!,
        );
      }

      return HttpResult<UserAsocResponse>(
        data: null,
        error: HttpError(
          exception: e,
          stackTrace: s,
          data: data,
        ),
        statusCode: statusCode ?? -1,
      );
    }
  }

  Future<HttpResult<UserAsocResponse>?> updateProfileStatus(int idUser, String profileUser, String statusUser, String dateUpdatedUser) async {
    int? statusCode;
    dynamic data;

    final body = jsonEncode({
      'id_user': idUser,
      'profile_user': profileUser,
      'status_user': statusUser,
      'date_updated_user': dateUpdatedUser,
    });

    final url = await EglConfig.uri(apiUser, EglConfig.apiUserProfileStatus);

    try {
      final response = await apiClient.post(url, body, token: '${session.getAuthToken}');

      statusCode = response.statusCode;

      if (response.statusCode == 200) {
        final UserAsocResponse userAsocResponse = userAsocResponseFromJson(await EglHelper.parseApiUrlBody(response.body));

        // print('Asociations Response body: ${asociationsResponse.result.records}');
        // return userAsocResponse;
        return HttpResult<UserAsocResponse>(
          data: userAsocResponse,
          statusCode: statusCode,
          error: null,
        );
      } else if (statusCode > 400) {
        data = parseResponseBody(await EglHelper.parseApiUrlBody(response.body));
        return HttpResult<UserAsocResponse>(
          data: null,
          error: HttpError(
            data: data,
            exception: null,
            stackTrace: StackTrace.current,
          ),
          statusCode: statusCode,
        );
      } else {
        data = parseResponseBody(await EglHelper.parseApiUrlBody(response.body));
        String message = data['message'];
        return HttpResult<UserAsocResponse>(
          data: null,
          error: HttpError(
            data: message,
            exception: null,
            stackTrace: StackTrace.current,
          ),
          statusCode: statusCode,
        );
      }

      // return null;
    } catch (e, s) {
      if (e is HttpError) {
        return HttpResult<UserAsocResponse>(
          data: null,
          error: e,
          statusCode: statusCode!,
        );
      }

      return HttpResult<UserAsocResponse>(
        data: null,
        error: HttpError(
          exception: e,
          stackTrace: s,
          data: data,
        ),
        statusCode: statusCode ?? -1,
      );
    }
  }

  Future<HttpResult<UsersListResponse>?> getAllUsers() async {
    int? statusCode;
    dynamic data;

    final url = await EglConfig.uri(apiUser, EglConfig.apiListAll);
    try {
      final response = await apiClient.get(url, token: '${session.getAuthToken}');

      statusCode = response.statusCode;

      // print('Response status: ${response.statusCode}');
      //   Helper.eglLogger('i', 'Response body: ${response.body}');
      if (response.statusCode == 200) {
        final UsersListResponse usersListResponse = usersListUserResponseFromJson(await EglHelper.parseApiUrlBody(response.body));

        // print('Asociations Response body: ${asociationsResponse.result.records}');
        // return userAsocResponse;
        return HttpResult<UsersListResponse>(
          data: usersListResponse,
          statusCode: statusCode,
          error: null,
        );
      } else if (statusCode > 400) {
        data = parseResponseBody(await EglHelper.parseApiUrlBody(response.body));
        return HttpResult<UsersListResponse>(
          data: null,
          error: HttpError(
            data: data,
            exception: null,
            stackTrace: StackTrace.current,
          ),
          statusCode: statusCode,
        );
      } else {
        data = parseResponseBody(await EglHelper.parseApiUrlBody(response.body));
        String message = data['message'];
        return HttpResult<UsersListResponse>(
          data: null,
          error: HttpError(
            data: message,
            exception: null,
            stackTrace: StackTrace.current,
          ),
          statusCode: statusCode,
        );
      }
    } catch (e, s) {
      if (e is HttpError) {
        return HttpResult<UsersListResponse>(
          data: null,
          error: e,
          statusCode: statusCode!,
        );
      }

      return HttpResult<UsersListResponse>(
        data: null,
        error: HttpError(
          exception: e,
          stackTrace: s,
          data: data,
        ),
        statusCode: statusCode ?? -1,
      );
    }
  }
}
