import 'package:asocapp/app/apirest/api_models/api_models.dart';
import 'package:asocapp/app/models/article_model.dart';

class IArticleArguments {
  final bool hasArticle;
  final Article article;

  IArticleArguments(this.article, {this.hasArticle = true});
}

class IArticleUserArguments {
  final ArticleUser article;

  IArticleUserArguments(this.article);
}

class IArticleNotifiedArguments {
  final int idArticle;

  IArticleNotifiedArguments(this.idArticle);
}
