// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

class ArticleState {
  final String value;
  final String name;

  ArticleState(
    this.value,
    this.name,
  );

  static List<ArticleState> listArticleState() {
    return <ArticleState>[
      ArticleState('redacción', 'cRedaction'),
      ArticleState('revisión', 'cRevision'),
      ArticleState('publicado', 'cPublished'),
      ArticleState('expirado', 'cExpired'),
      ArticleState('anulado', 'cCanceled'),
    ];
  }

  static getListArticleState() {
    List<ArticleState> listStates = listArticleState();

    List<dynamic> res = listStates
        .map((stat) => {
              'value': stat.value,
              'name': stat.name.tr,
            })
        .toList();
    return res;
  }
}
