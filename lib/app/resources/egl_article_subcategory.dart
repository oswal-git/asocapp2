// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

class ArticleSubcategory {
  final String category;
  final String value;
  final String name;

  ArticleSubcategory(
    this.category,
    this.value,
    this.name,
  );

  static List<ArticleSubcategory> listArticleSubcategory() {
    return <ArticleSubcategory>[
      ArticleSubcategory('noticias', 'municipio', 'cMunicipality'),
      ArticleSubcategory('noticias', 'urbanización', 'cUrbanization'),
      ArticleSubcategory('actas', 'asambleas', 'cAssemblies'),
      ArticleSubcategory('actas', 'reuniones', 'cMeetings'),
      ArticleSubcategory('información', 'servicios', 'cServices'),
      ArticleSubcategory('información', 'cultura', 'cCulture'),
      ArticleSubcategory('información', 'reuniones', 'cMeetings'),
      ArticleSubcategory('información', 'asambleas', 'cAssemblies'),
    ];
  }

  static getListArticleSubcategory() {
    List<ArticleSubcategory> listSubcategory = listArticleSubcategory();

    List<dynamic> res = listSubcategory
        .map((subcat) => {
              'category': subcat.category,
              'value': subcat.value,
              'name': subcat.name.tr,
            })
        .toList();
    return res;
  }
}
