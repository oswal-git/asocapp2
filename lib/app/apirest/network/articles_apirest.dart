import 'dart:convert';

import 'package:asocapp/app/apirest/api_models/api_models.dart';
import 'package:asocapp/app/apirest/api_models/article_plain_api_model.dart';
import 'package:asocapp/app/apirest/api_models/basic_response_model.dart';
import 'package:asocapp/app/apirest/response/api_response.dart';
import 'package:asocapp/app/apirest/utils/utils.dart';
import 'package:asocapp/app/config/config.dart';
import 'package:asocapp/app/models/image_article_model.dart';
import 'package:asocapp/app/models/item_article_model.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/services/session_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

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

    final url = await EglConfig.uri(apiArticles, '${EglConfig.apiSingleArticle}?id_article=$idarticle');
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

    final url = await EglConfig.uri(apiArticles, EglConfig.apiListAll);
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
      // String authToken = _session.getAuthToken();

      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer ${_session.getAuthToken}',
      };

      final Uri url = await EglConfig.uri(apiNotifications, EglConfig.apiListPending);
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
      EglHelper.eglLogger('e', 'Response try error: ${error.message}', object: error);
      return Future.value(NotificationArticleListResponse.clear());
    } catch (error) {
      // print('Response status: ${response.statusCode}');
      EglHelper.eglLogger('e', 'Response try error: ', object: error);
      return Future.value(NotificationArticleListResponse.clear());
    }
  }

  Future<HttpResult<ArticleUserResponse>?> createArticle(
      ArticlePlain articlePlain, ImageArticle imageCoverArticle, List<ItemArticle> articleItems) async {
    int? statusCode;
    dynamic data;

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${_session.getAuthToken}',
    };

    // string to uri
    final url = await EglConfig.uri(apiArticles, EglConfig.apiCreateArticle);

    // create multipart request
    http.MultipartRequest request = http.MultipartRequest('POST', url);

    //add headers
    request.headers.addAll(requestHeaders);

    //adding params
    request.fields['article'] = jsonEncode(articlePlain.toJson());
    request.fields['action'] = 'create';
    request.fields['module'] = 'articles';
    request.fields['prefix'] = 'images/asociation-${articlePlain.idAsociationArticle.toString()}';
    request.fields['user_name'] = _session.userConnected.nameUser;

    if (imageCoverArticle.isSelectedFile) {
      XFile image = imageCoverArticle.fileImage;
      String name = imageCoverArticle.nameFile;

      final http.ByteStream stream = http.ByteStream(image.openRead());
      stream.cast();
      // get file length
      var len = await image.length();

      // multipart that takes file
      http.MultipartFile multiport = http.MultipartFile(
        'file_cover',
        stream,
        len,
        filename: name,
      );

      request.files.add(multiport);
    }

    for (var i = 0; i < articleItems.length; i++) {
      if (articleItems[i].imageItemArticle.fileImage != null) {
        XFile image = articleItems[i].imageItemArticle.fileImage;
        int id = articleItems[i].idItemArticle;
        String name = articleItems[i].imageItemArticle.nameFile;

        final http.ByteStream stream = http.ByteStream(image.openRead());
        stream.cast();
        var len = await image.length();
        http.MultipartFile multiport = http.MultipartFile(
          'file_$id',
          stream,
          len,
          filename: name,
        );

        request.files.add(multiport);
      }
    }

    try {
      final response = await request.send();

      var res = await http.Response.fromStream(response);
      EglHelper.eglLogger('i', 'res.body: ${res.body}');
      // statusCode = response.statusCode;
      // response.stream.transform(utf8.decoder).listen((value) {
      //   var body1 = value;
      //   EglHelper.eglLogger('i', 'body1: $body1');
      // });

      if (response.statusCode == 200) {
        final ArticleUserResponse articleUserResponse = articleUserResponseFromJson(
          await EglHelper.parseApiUrlBody(res.body),
        );

        return HttpResult<ArticleUserResponse>(
          data: articleUserResponse,
          statusCode: response.statusCode,
          error: null,
        );
      } else if (response.statusCode > 400) {
        data = parseResponseBody(await EglHelper.parseApiUrlBody(res.body));
        return HttpResult<ArticleUserResponse>(
          data: null,
          error: HttpError(
            data: data,
            exception: null,
            stackTrace: StackTrace.current,
          ),
          statusCode: response.statusCode,
        );
      } else {
        data = parseResponseBody(await EglHelper.parseApiUrlBody(res.body));
        String message = data['message'];
        return HttpResult<ArticleUserResponse>(
          data: null,
          error: HttpError(
            data: message,
            exception: null,
            stackTrace: StackTrace.current,
          ),
          statusCode: response.statusCode,
        );
      }
    } catch (e, s) {
      if (e is HttpError) {
        return HttpResult<ArticleUserResponse>(
          data: null,
          error: e,
          statusCode: statusCode!,
        );
      }

      return HttpResult<ArticleUserResponse>(
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

  Future<HttpResult<ArticleUserResponse>?> modifyArticle(
      ArticlePlain articlePlain, ImageArticle imageCoverArticle, List<ItemArticle> articleItems) async {
    int? statusCode;
    dynamic data;

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${_session.getAuthToken}',
    };

    // string to uri
    final url = await EglConfig.uri(apiArticles, EglConfig.apiModifyArticle);

    // create multipart request
    http.MultipartRequest request = http.MultipartRequest('POST', url);

    //add headers
    request.headers.addAll(requestHeaders);

    //adding params
    request.fields['article'] = jsonEncode(articlePlain.toJson());
    request.fields['action'] = 'create';
    request.fields['module'] = 'articles';
    request.fields['prefix'] = 'images/asociation-${articlePlain.idAsociationArticle.toString()}';
    request.fields['user_name'] = _session.userConnected.nameUser;

    if (imageCoverArticle.isSelectedFile) {
      XFile image = imageCoverArticle.fileImage;
      String name = imageCoverArticle.nameFile;

      final http.ByteStream stream = http.ByteStream(image.openRead());
      stream.cast();
      // get file length
      var len = await image.length();

      // multipart that takes file
      http.MultipartFile multiport = http.MultipartFile(
        'file_cover',
        stream,
        len,
        filename: name,
      );

      request.files.add(multiport);
    }

    for (var i = 0; i < articleItems.length; i++) {
      if (articleItems[i].imageItemArticle.fileImage != null) {
        XFile image = articleItems[i].imageItemArticle.fileImage;
        int id = articleItems[i].idItemArticle;
        String name = articleItems[i].imageItemArticle.nameFile;

        final http.ByteStream stream = http.ByteStream(image.openRead());
        stream.cast();
        var len = await image.length();
        http.MultipartFile multiport = http.MultipartFile(
          'file_$id',
          stream,
          len,
          filename: name,
        );

        request.files.add(multiport);
      }
    }

    try {
      final response = await request.send();

      var res = await http.Response.fromStream(response);
      EglHelper.eglLogger('i', 'res.body: ${res.body}');
      // statusCode = response.statusCode;
      // response.stream.transform(utf8.decoder).listen((value) {
      //   var body1 = value;
      //   EglHelper.eglLogger('i', 'body1: $body1');
      // });

      if (response.statusCode == 200) {
        final ArticleUserResponse articleUserResponse = articleUserResponseFromJson(
          await EglHelper.parseApiUrlBody(res.body),
        );

        return HttpResult<ArticleUserResponse>(
          data: articleUserResponse,
          statusCode: response.statusCode,
          error: null,
        );
      } else if (response.statusCode > 400) {
        data = parseResponseBody(await EglHelper.parseApiUrlBody(res.body));
        return HttpResult<ArticleUserResponse>(
          data: null,
          error: HttpError(
            data: data,
            exception: null,
            stackTrace: StackTrace.current,
          ),
          statusCode: response.statusCode,
        );
      } else {
        data = parseResponseBody(await EglHelper.parseApiUrlBody(res.body));
        String message = data['message'];
        return HttpResult<ArticleUserResponse>(
          data: null,
          error: HttpError(
            data: message,
            exception: null,
            stackTrace: StackTrace.current,
          ),
          statusCode: response.statusCode,
        );
      }
    } catch (e, s) {
      if (e is HttpError) {
        return HttpResult<ArticleUserResponse>(
          data: null,
          error: e,
          statusCode: statusCode!,
        );
      }

      return HttpResult<ArticleUserResponse>(
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

  Future<HttpResult<BasicResponse>?> deleteArticle(int idArticle, String dateUpdatedArticle) async {
    int? statusCode;
    dynamic data;

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${_session.getAuthToken}',
    };

    final url = await EglConfig.uri(apiArticles, '${EglConfig.apiDeleteArticle}?id_article=$idArticle&date_updated_article=$dateUpdatedArticle');
    try {
      final response = await http.get(url, headers: requestHeaders);

      statusCode = response.statusCode;

      // print('Response status: ${response.statusCode}');
      //   Helper.eglLogger('i', 'Response body: ${response.body}');
      if (response.statusCode == 200) {
        final BasicResponse basicResponse = basicUserResponseFromJson(await EglHelper.parseApiUrlBody(response.body));

        // print('Asociations Response body: ${asociationsResponse.result.records}');
        // return userAsocResponse;
        return HttpResult<BasicResponse>(
          data: basicResponse,
          statusCode: statusCode,
          error: null,
        );
      } else if (statusCode > 400) {
        data = parseResponseBody(await EglHelper.parseApiUrlBody(response.body));
        return HttpResult<BasicResponse>(
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
        return HttpResult<BasicResponse>(
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
        return HttpResult<BasicResponse>(
          data: null,
          error: e,
          statusCode: statusCode!,
        );
      }

      return HttpResult<BasicResponse>(
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

  // end class
}
