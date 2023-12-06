import 'dart:io';

import 'package:asocapp/app/apirest/utils/app_exceptions.dart';
import 'package:asocapp/app/config/config.dart';
import 'package:asocapp/app/models/models.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class AsociationsApiRest {
  static final AsociationsApiRest _asociationsApiRest = AsociationsApiRest._internal();
  // static String apiAsoc = 'asociations';
  static String apiAsoc = 'asociations';
  final Logger logger = Logger();

  factory AsociationsApiRest() {
    return _asociationsApiRest;
  }

  // ignore: empty_constructor_bodies
  AsociationsApiRest._internal() {}

  Future<List<Asociation>?> refreshAsociations() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };

    try {
      final url = await EglConfig.uri(apiAsoc, EglConfig.apiListAll);

      final response = await http.get(url, headers: requestHeaders).timeout(
            const Duration(
              seconds: 10,
            ),
          );

      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      final AsociationsResponse asociationsResponse = asociationsResponseFromJson(await EglHelper.parseApiUrlBody(response.body));
      // print('Asociations Response body: ${asociationsResponse.result.records}');
      return Future.value(asociationsResponse.result.records);
    } on SocketException {
      throw FetchDataException('No internet connection');
    }
  }
}
