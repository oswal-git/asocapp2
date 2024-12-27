// import 'package:asociaciones/apirest/response/status.dart';
import 'dart:convert';

import 'package:asocapp/app/utils/helper.dart';
import 'package:http/http.dart' as http;

class ApiResponse<T> {
  int? status;
  String? message;
  T? result;

  ApiResponse(this.status, this.result, this.message);

  // ApiResponse.loading() : status = Status.LOADING;
  // ApiResponse.completed() : status = Status.COMPLETED;
  // ApiResponse.error() : status = Status.ERROR;
  ApiResponse.loading() : status = 1;
  ApiResponse.completed() : status = 2;
  ApiResponse.error() : status = -1;

  @override
  String toString() {
    return 'Status : $status \n Massage: $message \n Data : $result';
  }

  static Future<String> returnResponse(http.Response response) async {
    switch (response.statusCode) {
      case 200:
        // final AsociationsResponse asociationsResponse = asociationsResponseFromJson(response.body);
        // final dynamic responseJson = jsonDecode(response.body);
        // return responseJson;
        return await EglHelper.parseApiUrlBody(utf8.decode(response.bodyBytes));

      case 400:
        return response.body;
      // throw BadRequestException(response.body.toString());
      case 404:
      case 500:
        return response.body.toString() != '' ? response.body.toString() : 'Unauthorized  request';
      case 503:
        return response.body;
      default:
        return 'Error occurred while communicating with server with statusCode: ${response.statusCode.toString()}';
    }
  }
}
