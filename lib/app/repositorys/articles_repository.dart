import 'package:asocapp/app/apirest/api_models/api_models.dart';
import 'package:asocapp/app/apirest/api_models/article_plain_api_model.dart';
import 'package:asocapp/app/apirest/api_models/basic_response_model.dart';
import 'package:asocapp/app/apirest/network/articles_apirest.dart';
import 'package:asocapp/app/models/image_article_model.dart';
import 'package:asocapp/app/models/item_article_model.dart';
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

  Future<HttpResult<ArticleUserResponse>?> createArticle(
      ArticlePlain articlePlain, ImageArticle imageCoverArticle, List<ItemArticle> articleItems) async {
    return articlesApiRest.createArticle(articlePlain, imageCoverArticle, articleItems);
  }

  Future<HttpResult<ArticleUserResponse>?> modifyArticle(
      ArticlePlain articlePlain, ImageArticle imageCoverArticle, List<ItemArticle> articleItems) async {
    return articlesApiRest.modifyArticle(articlePlain, imageCoverArticle, articleItems);
  }

  Future<HttpResult<BasicResponse>?> deleteArticle(int idArticle, String dateUpdatedArticle) async {
    return articlesApiRest.deleteArticle(idArticle, dateUpdatedArticle);
  }
}
