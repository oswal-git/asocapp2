import 'dart:convert';

import 'package:asocapp/app/apirest/api_models/api_models.dart';
import 'package:asocapp/app/apirest/response/response.dart';
import 'package:asocapp/app/apirest/utils/utils.dart';
import 'package:asocapp/app/config/config.dart';
import 'package:asocapp/app/services/session_service.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:logger/logger.dart';

class AuthApiRest {
  SessionService session = Get.put<SessionService>(SessionService());

  static String apiUser = 'users';
  static Logger logger = Logger();

  Future<HttpResult<UserAsocResponse>?> registerGenericUser(
      String username, int asociationId, String password, String question, String answer) async {
    int? statusCode;
    dynamic data;

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };

    final body = jsonEncode({
      'user_name_user': username,
      'id_asociation_user': asociationId,
      'password_user': password,
      'question_user': question,
      'answer_user': answer,
    });

    logger.i('password: $password');

    final url = await EglConfig.uri(apiUser, EglConfig.apiRegister);

    try {
      final response = await http.post(url, headers: requestHeaders, body: body);

      statusCode = response.statusCode;

      if (statusCode >= 400) {
        data = parseResponseBody(await EglHelper.parseApiUrlBody(response.body));
        throw HttpError(
          data: data,
          stackTrace: StackTrace.current,
          exception: null,
        );
      }

      final UserAsocResponse userCreated = userAsocResponseFromJson(await EglHelper.parseApiUrlBody(response.body));
      return HttpResult<UserAsocResponse>(
        data: userCreated,
        statusCode: statusCode,
        error: null,
      );

      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      // if (response.statusCode == 200) {
      //   // print('Asociations Response body: ${asociationsResponse.result.records}');
      //   return userCreated;
      // }

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

  Future<UserAsocResponse?> login(String username, int asociationId, String password) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
    };

    final body = jsonEncode({
      'user_name_user': username,
      'id_asociation_user': asociationId,
      'password_user': password,
    });

    // Helper.eglLogger('w', 'body: $body');

    final url = await EglConfig.uri(apiUser, EglConfig.apiUserLogin);

    final response = await http.post(url, headers: requestHeaders, body: body);

    // logger.i('Response status: ${response.statusCode}');
    // logger.i('Tamaño body: ${response.body.length}');
    // logger.i('Response body: ${response.body.substring(0, 500)}');
    // logger.i('Response body: ${response.body.substring(500, 1000)}');
    // logger.i('Response body: ${response.body.substring(1000, response.body.length)}');
    final dynamic responseBody = await ApiResponse.retrunResponse(response);

    if (response.statusCode == 200) {
      //   Helper.eglLogger('w', 'Response body: $responseBody');
      // logger.i('Response body: $responseBody');
      final UserAsocResponse userAsocData = userAsocResponseFromJson(responseBody);

      // print('Asociations Response body: ${asociationsResponse.result.records}');
      return userAsocData;
    }

    return null;
  }

  Future<UserAsocResponse?> change(String username, int asociationId, String password, String newPassword) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${session.getAuthToken}',
    };

    final body = jsonEncode({
      'user_name_user': username,
      'id_asociation_user': asociationId,
      'password_user': password,
      'new_password_user': newPassword,
    });

    logger.i('body: $body');

    final url = await EglConfig.uri(apiUser, EglConfig.apiChange);

    final response = await http.post(url, headers: requestHeaders, body: body);

    // logger.i('Response status: ${response.statusCode}');
    // logger.i('Tamaño body: ${response.body.length}');
    // logger.i('Response body: ${response.body.substring(0, 500)}');
    // logger.i('Response body: ${response.body.substring(500, 1000)}');
    // logger.i('Response body: ${response.body.substring(1000, response.body.length)}');
    final dynamic responseBody = await ApiResponse.retrunResponse(response);

    if (response.statusCode == 200) {
      logger.i('Response body: $responseBody');
      final UserAsocResponse userAsocData = userAsocResponseFromJson(responseBody);

      // print('Asociations Response body: ${asociationsResponse.result.records}');
      return userAsocData;
    }

    return null;
  }

  Future<HttpResult<UserResetResponse>?> reset(String email) async {
    int? statusCode;
    dynamic data;

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };

    final body = jsonEncode({
      'email_user': email,
    });

    logger.i('email: $email');

    final url = await EglConfig.uri(apiUser, EglConfig.apiReset);

    try {
      final response = await http.post(url, headers: requestHeaders, body: body);

      statusCode = response.statusCode;

      if (response.statusCode == 200) {
        final UserResetResponse userResetResponse = userResetResponseFromJson(await EglHelper.parseApiUrlBody(response.body));

        // print('Asociations Response body: ${asociationsResponse.result.records}');
        // return userResetResponse;
        return HttpResult<UserResetResponse>(
          data: userResetResponse,
          statusCode: statusCode,
          error: null,
        );
      } else if (statusCode > 400) {
        data = parseResponseBody(await EglHelper.parseApiUrlBody(response.body));
        return HttpResult<UserResetResponse>(
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
        return HttpResult<UserResetResponse>(
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
        return HttpResult<UserResetResponse>(
          data: null,
          error: e,
          statusCode: statusCode!,
        );
      }

      return HttpResult<UserResetResponse>(
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
