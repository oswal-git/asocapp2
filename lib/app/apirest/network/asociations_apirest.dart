import 'package:asocapp/app/apirest/network/network.dart';
import 'package:asocapp/app/config/config.dart';
import 'package:asocapp/app/models/models.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:logger/logger.dart';

class AsociationsApiRest {
  static final AsociationsApiRest _asociationsApiRest = AsociationsApiRest._internal();
  final ApiClient apiClient = ApiClient();

  // static String apiAsoc = 'asociations';
  static String apiAsoc = 'asociations';
  final Logger logger = Logger();

  factory AsociationsApiRest() {
    return _asociationsApiRest;
  }

  // ignore: empty_constructor_bodies
  AsociationsApiRest._internal() {}

  Future<List<Asociation>?> refreshAsociations() async {
    // Map<String, String> requestHeaders = {
    //   'Content-type': 'application/json',
    // };

    final url = await EglConfig.uri(apiAsoc, EglConfig.apiListAll);

    final response = await apiClient.get(url);

    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    final AsociationsResponse asociationsResponse = asociationsResponseFromJson(await EglHelper.parseApiUrlBody(response.body));
    // print('Asociations Response body: ${asociationsResponse.result.records}');
    return Future.value(asociationsResponse.result.records);
  }
}
