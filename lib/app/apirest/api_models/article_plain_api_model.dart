import 'package:asocapp/app/apirest/api_models/item_article_plain_model.dart';
import 'package:asocapp/app/models/article_model.dart';
import 'package:asocapp/app/models/image_article_model.dart';

import 'package:intl/intl.dart';

class ArticlePlain {
  int idArticle;
  int idAsociationArticle;
  int idUserArticle;
  String categoryArticle;
  String subcategoryArticle;
  String classArticle;
  String stateArticle;
  String publicationDateArticle;
  String effectiveDateArticle;
  String expirationDateArticle;
  String titleArticle;
  String abstractArticle;
  String ubicationArticle;
  String dateDeletedArticle;
  String dateCreatedArticle;
  String dateUpdatedArticle;
  List<ItemArticlePlain> itemsArticlePlain;

  ArticlePlain({
    required this.idArticle,
    required this.idAsociationArticle,
    required this.idUserArticle,
    required this.categoryArticle,
    required this.subcategoryArticle,
    required this.classArticle,
    required this.stateArticle,
    required this.publicationDateArticle,
    required this.effectiveDateArticle,
    required this.expirationDateArticle,
    required this.titleArticle,
    required this.abstractArticle,
    required this.ubicationArticle,
    required this.dateDeletedArticle,
    required this.dateCreatedArticle,
    required this.dateUpdatedArticle,
    required this.itemsArticlePlain,
  });

  factory ArticlePlain.fromArticle({
    required Article article,
  }) {
    return ArticlePlain(
      idArticle: article.idArticle,
      idAsociationArticle: article.idAsociationArticle,
      idUserArticle: article.idUserArticle,
      categoryArticle: article.categoryArticle,
      subcategoryArticle: article.subcategoryArticle,
      classArticle: article.classArticle,
      stateArticle: article.stateArticle,
      publicationDateArticle: article.publicationDateArticle,
      effectiveDateArticle: article.effectiveDateArticle,
      expirationDateArticle: article.expirationDateArticle,
      titleArticle: article.titleArticle,
      abstractArticle: article.abstractArticle,
      ubicationArticle: article.ubicationArticle,
      dateDeletedArticle: article.dateDeletedArticle,
      dateCreatedArticle: article.dateCreatedArticle,
      dateUpdatedArticle: article.dateUpdatedArticle,
      itemsArticlePlain: List<ItemArticlePlain>.from(article.itemsArticle.map((e) => ItemArticlePlain.fromItemArticle(e))),
      // Proporciona otros valores específicos de ArticlePlain aquí
    );
  }

  factory ArticlePlain.fromJson(Map<String, dynamic> json) => ArticlePlain(
        idArticle: json["id_article"],
        idAsociationArticle: json["id_asociation_article"],
        idUserArticle: json["id_user_article"],
        categoryArticle: json["category_article"],
        subcategoryArticle: json["subcategory_article"],
        classArticle: json["class_article"],
        stateArticle: json["state_article"],
        publicationDateArticle: (json["publication_date_article"]),
        effectiveDateArticle: (json["effective_date_article"]),
        expirationDateArticle: json["expiration_date_article"],
        titleArticle: json["title_article"],
        abstractArticle: json["abstract_article"],
        ubicationArticle: json["ubication_article"],
        dateDeletedArticle: json["date_deleted_article"],
        dateCreatedArticle: (json["date_created_article"]),
        dateUpdatedArticle: (json["date_updated_article"]),
        itemsArticlePlain: List<ItemArticlePlain>.from(json["items_article"].map((x) => ItemArticlePlain.fromJson(x))),
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> toJson = {
      "id_article": idArticle,
      "id_asociation_article": idAsociationArticle,
      "id_user_article": idUserArticle,
      "category_article": categoryArticle,
      "subcategory_article": subcategoryArticle,
      "class_article": classArticle,
      "state_article": stateArticle,
      "publication_date_article": publicationDateArticle,
      "effective_date_article": effectiveDateArticle,
      "expiration_date_article": expirationDateArticle,
      "title_article": titleArticle,
      "abstract_article": abstractArticle,
      "ubication_article": ubicationArticle,
      "date_deleted_article": dateDeletedArticle,
      "date_created_article": dateCreatedArticle,
      "date_updated_article": dateUpdatedArticle,
      "items_article_plain": List<dynamic>.from(itemsArticlePlain.map((x) => x.toJson())),
    };

    return toJson;
  }

  @override
  String toString() {
    String cadena = '';

    cadena = '$cadena Article { ';
    cadena = '$cadena idArticle: $idArticle,';
    cadena = '$cadena idAsociationArticle: $idAsociationArticle,';
    cadena = '$cadena idUserArticle: $idUserArticle,';
    cadena = '$cadena categoryArticle: $categoryArticle,';
    cadena = '$cadena subcategoryArticle: $subcategoryArticle,';
    cadena = '$cadena classArticle: $classArticle,';
    cadena = '$cadena stateArticle: $stateArticle,';
    cadena = '$cadena publicationDateArticle: $publicationDateArticle,';
    cadena = '$cadena effectiveDateArticle: $effectiveDateArticle,';
    cadena = '$cadena expirationDateArticle: $expirationDateArticle,';
    cadena = '$cadena titleArticle: $titleArticle,';
    cadena = '$cadena abstractArticle: $abstractArticle,';
    cadena = '$cadena ubicationArticle: $ubicationArticle,';
    cadena = '$cadena dateDeletedArticle: $dateDeletedArticle,';
    cadena = '$cadena dateCreatedArticle: $dateCreatedArticle,';
    cadena = '$cadena dateUpdatedArticle: $dateUpdatedArticle,';
    itemsArticlePlain.map((e) {
      cadena = '$cadena itemsArticlePlain[${e.idItemArticle}]: ${e.toString()},';
      return;
    });

    return cadena;
  }

  factory ArticlePlain.clear() {
    return ArticlePlain(
      idArticle: 0,
      idAsociationArticle: 0,
      idUserArticle: 0,
      categoryArticle: '',
      subcategoryArticle: '',
      classArticle: '',
      stateArticle: 'redacción',
      publicationDateArticle: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      effectiveDateArticle: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      expirationDateArticle: '',
      titleArticle: '',
      abstractArticle: '',
      ubicationArticle: '',
      dateDeletedArticle: '',
      dateCreatedArticle: '',
      dateUpdatedArticle: '',
      itemsArticlePlain: [],
    );
  }

  ArticlePlain copyWith({
    int? idArticle,
    int? idAsociationArticle,
    int? idUserArticle,
    String? categoryArticle,
    String? subcategoryArticle,
    String? classArticle,
    String? stateArticle,
    String? publicationDateArticle,
    String? effectiveDateArticle,
    String? expirationDateArticle,
    ImageArticle? coverImageArticle,
    String? titleArticle,
    String? abstractArticle,
    String? ubicationArticle,
    String? dateDeletedArticle,
    String? dateCreatedArticle,
    String? dateUpdatedArticle,
    List<ItemArticlePlain>? itemsArticlePlain,
  }) {
    return ArticlePlain(
      idArticle: idArticle ?? this.idArticle,
      idAsociationArticle: idAsociationArticle ?? this.idAsociationArticle,
      idUserArticle: idUserArticle ?? this.idUserArticle,
      categoryArticle: categoryArticle ?? this.categoryArticle,
      subcategoryArticle: subcategoryArticle ?? this.subcategoryArticle,
      classArticle: classArticle ?? this.classArticle,
      stateArticle: stateArticle ?? this.stateArticle,
      publicationDateArticle: publicationDateArticle ?? this.publicationDateArticle,
      effectiveDateArticle: effectiveDateArticle ?? this.effectiveDateArticle,
      expirationDateArticle: expirationDateArticle ?? this.expirationDateArticle,
      titleArticle: titleArticle ?? this.titleArticle,
      abstractArticle: abstractArticle ?? this.abstractArticle,
      ubicationArticle: ubicationArticle ?? this.ubicationArticle,
      dateDeletedArticle: dateDeletedArticle ?? this.dateDeletedArticle,
      dateCreatedArticle: dateCreatedArticle ?? this.dateCreatedArticle,
      dateUpdatedArticle: dateUpdatedArticle ?? this.dateUpdatedArticle,
      itemsArticlePlain: itemsArticlePlain ?? this.itemsArticlePlain,
    );
  }
}
