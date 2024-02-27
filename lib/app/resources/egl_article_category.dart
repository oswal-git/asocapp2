// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

class ArticleCategory {
  final String value;
  final String name;

  ArticleCategory(
    this.value,
    this.name,
  );

  static List<ArticleCategory> listArticleCategory() {
    return <ArticleCategory>[
      ArticleCategory('información', 'cInformation'),
      ArticleCategory('noticias', 'cNews'),
      ArticleCategory('actas', 'cMinutes'),
    ];
  }

  static getListArticleCategory() {
    List<ArticleCategory> listCategory = listArticleCategory();

    List<dynamic> res = listCategory
        .map((cat) => {
              'value': cat.value,
              'name': cat.name.tr,
            })
        .toList();
    return res;
  }
}
