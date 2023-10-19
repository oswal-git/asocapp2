import 'package:asocapp/app/apirest/api_models/api_models.dart';
import 'package:asocapp/app/apirest/network/articles_apirest.dart';
import 'package:get/get.dart';

class ArticlesRepository {
  ArticlesApiRest articlesApiRest = Get.put<ArticlesApiRest>(ArticlesApiRest());

  Future<NotificationArticleListResponse> getPendingNotifyArticlesList() => articlesApiRest.getPendingNotifyArticlesList();

  Future<ArticleListResponse> getArticles() async {
    return articlesApiRest.getArticles();
  }

  Future<ArticleResponse> getSingleArticle(int idarticle) async {
    return articlesApiRest.getSingleArticle(idarticle);
  }
}
