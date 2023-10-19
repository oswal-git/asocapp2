import 'package:asocapp/app/apirest/api_models/article_model.dart';
import 'package:asocapp/app/apirest/api_models/notification_article_model.dart';
import 'package:asocapp/app/apirest/response/api_response.dart';
import 'package:asocapp/app/config/config.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/services/session_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ArticlesApiRest {
  final SessionService _session = Get.put(SessionService());

  static String apiArticles = 'articles';
  static String apiNotifications = 'notifications';

  Future<ArticleResponse> getSingleArticle(int idarticle) async {
    String authToken = _session.getAuthToken();

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $authToken',
    };

    final url = await Config.uri(apiArticles, '${Config.apiSingleArticle}?id_article=$idarticle');
    // Helper.eglLogger('i', 'Response body: ${url.toString()}');

    final response = await http.get(url, headers: requestHeaders);

    // print('Response status: ${response.statusCode}');
    // Helper.eglLogger('i','Response body: ${await Helper.parseApiUrlBody(response.body)}');

    final ArticleResponse articleResponse = articleResponseFromJson(await ApiResponse.retrunResponse(response));

    // print('Articlciations Response body: ${articlesList.result.records}');

    return articleResponse;
  }

  Future<ArticleListResponse> getArticles() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${_session.getAuthToken}',
    };

    final url = await Config.uri(apiArticles, Config.apiListAll);
    // Helper.eglLogger('i', 'Response body: ${url.toString()}');

    final response = await http.get(url, headers: requestHeaders);

    // print('Response status: ${response.statusCode}');
    // Helper.eglLogger('i', 'Response body: ${await Helper.parseApiUrlBody(response.body)}');

    final ArticleListResponse articlesListResponse = articleListResponseFromJson(await ApiResponse.retrunResponse(response));

    // print('Articlciations Response body: ${articlesList.result.records}');

    return articlesListResponse;
  }

  Future<NotificationArticleListResponse> getPendingNotifyArticlesList() async {
    try {
      String authToken = _session.getAuthToken();

      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $authToken',
      };

      final Uri url = await Config.uri(apiNotifications, Config.apiListPending);
      // Helper.eglLogger('i', 'requestHeaders: ${requestHeaders.toString()}');
      // Helper.eglLogger('i', 'url: ${url.toString()}');
      // Helper.eglLogger('i', 'ArticlesApiRest: getPendingNotifyArticlesList -> getAuthToken -> tokenUser: $authToken');

      final http.Response response = await http.get(url, headers: requestHeaders);

      // print('Response status: ${response.statusCode}');
      // Helper.eglLogger('i', 'Response body: ${Helper.parseApiUrlBody(response.body)}');

      final decodeResponse = await ApiResponse.retrunResponse(response);
      //   Helper.eglLogger('i', 'ArticlesApiRest: getPendingNotifyArticlesList -> decodeResponse: $decodeResponse');
      final NotificationArticleListResponse notificationArticleListResponse = notificationArticleListResponseFromJson(decodeResponse);

      return Future.value(notificationArticleListResponse);
    } on FormatException catch (error) {
      // print('Response status: ${response.statusCode}');
      Helper.eglLogger('e', 'Response try error: ${error.message}', object: error);
      return Future.value(NotificationArticleListResponse.clear());
    } catch (error) {
      // print('Response status: ${response.statusCode}');
      Helper.eglLogger('e', 'Response try error: ', object: error);
      return Future.value(NotificationArticleListResponse.clear());
    }
  }
}
