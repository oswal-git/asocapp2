import 'dart:convert';

import 'package:asocapp/app/apirest/response/response.dart';
import 'package:asocapp/app/apirest/utils/utils.dart';
import 'package:asocapp/app/config/config.dart';
import 'package:asocapp/app/services/session_service.dart';
import 'package:asocapp/app/utils/helper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
}
