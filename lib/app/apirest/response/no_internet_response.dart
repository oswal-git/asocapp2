import 'package:http/http.dart' as http;

class NoInternetResponse extends http.Response {
  final int codeStatus;
  final String reason;

  NoInternetResponse({
    this.codeStatus = 503,
    this.reason = 'No hay conexión a internet',
  }) : super('', codeStatus); // Código de estado 503: Service Unavailable

  @override
  String toString() {
    return reason;
  }

  @override
  String get body {
    return '{"status":$codeStatus,"message":$reason,"result":null}';
  }

  @override
  Map<String, String> get headers {
    return {};
  }

  @override
  bool get isRedirect {
    return false;
  }

  @override
  String get reasonPhrase {
    return reason;
  }

  @override
  int get statusCode {
    return codeStatus;
  }
}
