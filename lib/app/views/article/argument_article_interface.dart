import 'package:asocapp/app/apirest/api_models/api_models.dart';

class IArticleArguments {
  final Article article;

  IArticleArguments(this.article);
}

class IArticleNotifiedArguments {
  final int idArticle;

  IArticleNotifiedArguments(this.idArticle);
}
