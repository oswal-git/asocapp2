import 'package:asocapp/app/apirest/api_models/api_models.dart';
import 'package:asocapp/app/services/session_service.dart';
import 'package:asocapp/app/repositorys/articles_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArticleNotifiedController extends ChangeNotifier {
  final SessionService session = Get.put<SessionService>(SessionService());

  ArticlesRepository articlesRepository = ArticlesRepository();

  final _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;

  Future<bool> isLogin() async => session.isLogin;

  final _article = Rx<ArticleUser>(ArticleUser.clear());
  ArticleUser get article => _article.value;

  Future<ArticleUser> getSingleArticle(int idarticle) async {
    final ArticleResponse articlesResponse = await articlesRepository.getSingleArticle(idarticle);

    // print('Response body: ${result}');
    if (articlesResponse.status == 200) {
      _article.value = articlesResponse.result;
    } else {
      _article.value = ArticleUser.clear();
    }
    return _article.value;
  }

  exitSession() {
    session.exitSession();
  }
}
