import 'dart:convert';

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

  final String apiUser = 'users';
  final Logger logger = Logger();

  Future<QuestionListUserResponse?> getAllQuestionByUsernameAndAsociationId(String username, int asociationId) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };

    final url = await Config.uri(apiUser, '${Config.apiListAllQuestions}?user_name_user=$username&id_asociation_user=$asociationId');

    final response = await http.get(url, headers: requestHeaders);

    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      final QuestionListUserResponse questionListUserResponse = questionListUserResponseFromJson(await ApiResponse.retrunResponse(response));

      // print('Asociations Response body: ${asociationsResponse.result.records}');
      return questionListUserResponse;
    }

    return null;
  }

  Future<HttpResult<UserPassResponse>?> validateKey(String username, int asociationId, String question, String key) async {
    int? statusCode;
    dynamic data;

    Map<String, String> requestHeaders = {
      'Content-type': 'lication/json',
    };

    final body = jsonEncode({
      'user_name_user': username,
      'id_asociation_user': asociationId,
      'question_user': question,
      'answer_user': key,
    });

    logger.i('answer_user: $key');

    final url = await Config.uri(apiUser, Config.apiValidateKey);

    try {
      final response = await http.post(url, headers: requestHeaders, body: body);

      statusCode = response.statusCode;

      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final UserPassResponse userPassResponse = userPassResponseFromJson(await Helper.parseApiUrlBody(response.body));

        // print('Asociations Response body: ${asociationsResponse.result.records}');
        // return userPassResponse;
        return HttpResult<UserPassResponse>(
          data: userPassResponse,
          statusCode: statusCode,
          error: null,
        );
      } else if (statusCode > 400) {
        data = parseResponseBody(await Helper.parseApiUrlBody(response.body));
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
        data = parseResponseBody(await Helper.parseApiUrlBody(response.body));
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
    int? statusCode;
    dynamic data;

    var stream = http.ByteStream(imageAvatar.openRead());
    stream.cast();

    // var stream = imageAvatar.readAsBytes().asStream();

    var len = await imageAvatar.length();

    final url = await Config.uri(apiUser, Config.apiUserProfileAvatar);

    http.MultipartRequest request = http.MultipartRequest('POST', url);

    request.fields['id_user'] = idUser.toString();
    request.fields['user_name_user'] = userName;
    request.fields['id_asociation_user'] = asociationId.toString();
    request.fields['time_notifications_user'] = intervalNotifications.toString();
    request.fields['language_user'] = languageUser;
    request.fields['date_updated_user'] = dateUpdatedUser;

    request.fields['action'] = 'profile';
    request.fields['module'] = 'users';
    request.fields['prefix'] = 'avatars/user-$idUser';
    request.fields['date_updated'] = dateUpdatedUser;
    request.fields['token'] = session.getAuthToken;
    request.fields['user_name'] = userName;
    request.fields['name'] = '$userName.png';
    request.fields['cover'] = '';

    http.MultipartFile multiport = http.MultipartFile('file', stream, len, filename: '$userName.png');

    request.files.add(multiport);

    try {
      final response = await request.send();

      statusCode = response.statusCode;

      if (response.statusCode == 200) {
        String body = await response.stream.bytesToString();
        // Map body = jsonDecode(await response.stream.bytesToString());
        // logger.i('response.stream.bytesToString($statusCode): $map');
        // final body = await utf8.decodeStream(response.stream);
        logger.i('body($statusCode): $body');

        final UserAsocResponse userAsocResponse = userAsocResponseFromJson(await Helper.parseApiUrlBody(body));

        // print('Asociations Response body: ${asociationsResponse.result.records}');
        // return userAsocResponse;
        return HttpResult<UserAsocResponse>(
          data: userAsocResponse,
          statusCode: statusCode,
          error: null,
        );
      } else if (statusCode > 400) {
        Map map = jsonDecode(await response.stream.bytesToString());
        logger.i('response.stream.bytesToString($statusCode): $map');
        final body = await utf8.decodeStream(response.stream);
        data = parseResponseBody(await Helper.parseApiUrlBody(body));
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
        Map map = jsonDecode(await response.stream.bytesToString());
        logger.i('response.stream.bytesToString($statusCode): $map');
        final body = await utf8.decodeStream(response.stream);
        data = parseResponseBody(await Helper.parseApiUrlBody(body));
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

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${session.getAuthToken}',
    };

    final body = jsonEncode({
      'id_user': idUser,
      'user_name_user': userName,
      'id_asociation_user': asociationId,
      'time_notifications_user': intervalNotifications,
      'language_user': languageUser,
      'date_updated_user': dateUpdatedUser,
    });

    final url = await Config.uri(apiUser, Config.apiUserProfile);

    try {
      final response = await http.post(url, headers: requestHeaders, body: body);

      statusCode = response.statusCode;

      if (response.statusCode == 200) {
        final UserAsocResponse userAsocResponse = userAsocResponseFromJson(await Helper.parseApiUrlBody(response.body));

        // print('Asociations Response body: ${asociationsResponse.result.records}');
        // return userAsocResponse;
        return HttpResult<UserAsocResponse>(
          data: userAsocResponse,
          statusCode: statusCode,
          error: null,
        );
      } else if (statusCode > 400) {
        data = parseResponseBody(await Helper.parseApiUrlBody(response.body));
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
        data = parseResponseBody(await Helper.parseApiUrlBody(response.body));
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

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${session.getAuthToken}',
    };

    final body = jsonEncode({
      'id_user': idUser,
      'profile_user': profileUser,
      'status_user': statusUser,
      'date_updated_user': dateUpdatedUser,
    });

    final url = await Config.uri(apiUser, Config.apiUserProfileStatus);

    try {
      final response = await http.post(url, headers: requestHeaders, body: body);

      statusCode = response.statusCode;

      if (response.statusCode == 200) {
        final UserAsocResponse userAsocResponse = userAsocResponseFromJson(await Helper.parseApiUrlBody(response.body));

        // print('Asociations Response body: ${asociationsResponse.result.records}');
        // return userAsocResponse;
        return HttpResult<UserAsocResponse>(
          data: userAsocResponse,
          statusCode: statusCode,
          error: null,
        );
      } else if (statusCode > 400) {
        data = parseResponseBody(await Helper.parseApiUrlBody(response.body));
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
        data = parseResponseBody(await Helper.parseApiUrlBody(response.body));
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

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${session.getAuthToken}',
    };

    final url = await Config.uri(apiUser, Config.apiListAll);
    try {
      final response = await http.get(url, headers: requestHeaders);

      statusCode = response.statusCode;

      // print('Response status: ${response.statusCode}');
      //   Helper.eglLogger('i', 'Response body: ${response.body}');
      if (response.statusCode == 200) {
        final UsersListResponse usersListResponse = usersListUserResponseFromJson(await Helper.parseApiUrlBody(response.body));

        // print('Asociations Response body: ${asociationsResponse.result.records}');
        // return userAsocResponse;
        return HttpResult<UsersListResponse>(
          data: usersListResponse,
          statusCode: statusCode,
          error: null,
        );
      } else if (statusCode > 400) {
        data = parseResponseBody(await Helper.parseApiUrlBody(response.body));
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
        data = parseResponseBody(await Helper.parseApiUrlBody(response.body));
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
