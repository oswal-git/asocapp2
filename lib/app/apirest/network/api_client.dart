import 'dart:async';
import 'dart:io';
import 'package:asocapp/app/apirest/response/response.dart';
import 'package:asocapp/app/services/services.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class ApiClient {
  final SessionService session = Get.put<SessionService>(SessionService());

  static final ApiClient _instance = ApiClient._internal();
  late http.Client _client;
  // Establecer el tiempo de espera en 10 segundos
  Duration timeout = const Duration(seconds: 10);

  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal() {
    _client = http.Client();
  }

  Future<http.Response> post(Uri url, String body, {String token = ''}) async {
    // Verificar la conexión a internet
    Future<http.Response> response;

    if (!(await hasInternetconnection())) {
      return NoInternetResponse();
    }

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Charset': 'utf-8',
    };

    if (token != '') {
      requestHeaders['Authorization'] = 'Bearer $token';
    }

    // Establecer el tiempo de espera
    // var timeout = const Duration(seconds: 10);
    try {
      response = _client.post(url, headers: requestHeaders, body: body).timeout(timeout);
      return response;
    } on TimeoutException {
      // Captura de la excepción TimeoutException
      EglHelper.eglLogger('i', 'Se produjo una excepción: TimeoutExceptionResponse');
      return TimeoutExceptionResponse();
    } on SocketException {
      // Captura de la excepción TimeoutException
      EglHelper.eglLogger('i', 'Se produjo una excepción: SocketException');
      return NoInternetResponse(reason: 'Error during Communication');
    } catch (e) {
      // if (e is TimeoutException) {
      // } else {
      // Captura de otras excepciones
      EglHelper.eglLogger('i', 'Se produjo una excepción: $e');
      return GenericResponse();
      // }
    }

    // Realizar la solicitud HTTP con un tiempo de espera
  }

  Future<http.Response> get(Uri url, {String token = ''}) async {
    // Verificar la conexión a internet
    Future<http.Response> response;

    if (!(await hasInternetconnection())) {
      return NoInternetResponse();
    }

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };

    if (token != '') {
      requestHeaders['Authorization'] = 'Bearer $token';
    }

    // Establecer el tiempo de espera
    // var timeout = const Duration(seconds: 10);
    try {
      response = _client.get(url, headers: requestHeaders).timeout(timeout);
      return response;
    } on TimeoutException {
      // Captura de la excepción TimeoutException
      EglHelper.eglLogger('i', 'Se produjo una excepción: TimeoutExceptionResponse');
      return TimeoutExceptionResponse();
    } on SocketException {
      // Captura de la excepción TimeoutException
      EglHelper.eglLogger('i', 'Se produjo una excepción: SocketException');
      return NoInternetResponse(reason: 'Error during Communication');
    } catch (e) {
      // if (e is TimeoutException) {
      // } else {
      // Captura de otras excepciones
      EglHelper.eglLogger('i', 'Se produjo una excepción: $e');
      return GenericResponse();
      // }
    }

    // Realizar la solicitud HTTP con un tiempo de espera
  }

  Future<http.Response> sendMultipartRequest({
    required Uri url,
    required String endpoint,
    required Map<String, String> headers,
    required Map<String, dynamic> fields,
    required List<http.MultipartFile> files,
  }) async {
    if ((!await hasInternetconnection())) {
      return NoInternetResponse();
    }

    final request = http.MultipartRequest('POST', url);

    // Añadir encabezados
    request.headers.addAll(headers);

    // Añadir campos
    fields.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    // Añadir archivos
    for (var file in files) {
      request.files.add(file);
    }

    // Enviar la solicitud
    try {
      final response = await request.send().timeout(timeout);

      // Esperar la respuesta y decodificarla
      final responseData = await http.Response.fromStream(response);

      // Construir y devolver la respuesta
      return http.Response(responseData.body, response.statusCode);
    } on TimeoutException {
      // Captura de la excepción TimeoutException
      EglHelper.eglLogger('i', 'Se produjo una excepción: TimeoutExceptionResponse');
      return TimeoutExceptionResponse();
    } on SocketException {
      // Captura de la excepción TimeoutException
      EglHelper.eglLogger('i', 'Se produjo una excepción: SocketException');
      return NoInternetResponse(reason: 'Error during Communication');
    } catch (e) {
      // if (e is TimeoutException) {
      // } else {
      // Captura de otras excepciones
      EglHelper.eglLogger('i', 'Se produjo una excepción: $e');
      return GenericResponse();
      // }
    }
  }

  // Otros métodos para realizar diferentes tipos de solicitudes (post, put, delete, etc.)

  Future<bool> hasInternetconnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      session.thereIsInternetconnection = false;
      return false;
    }
    session.thereIsInternetconnection = true;
    return true;
  }
  // end class
}
