import 'dart:convert';

import 'package:asocapp/app/models/image_article_model.dart';
import 'package:asocapp/app/models/item_article_model.dart';

ItemArticlePlain itemArticlePlainRequestFromJson(String str) => ItemArticlePlain.fromJson(json.decode(str));

String itemArticlePlainRequestToJson(ItemArticlePlain data) => json.encode(data.toJson());

class ItemArticlePlain {
  int idItemArticle;
  int idArticleItemArticle;
  String textItemArticle;
  int imagesIdItemArticle;
  String dateCreatedItemArticle;

  ItemArticlePlain({
    required this.idItemArticle,
    required this.idArticleItemArticle,
    required this.textItemArticle,
    required this.imagesIdItemArticle,
    required this.dateCreatedItemArticle,
  });

  factory ItemArticlePlain.fromItemArticle(
    ItemArticle itemArticle,
  ) {
    return ItemArticlePlain(
      idItemArticle: itemArticle.idItemArticle,
      idArticleItemArticle: itemArticle.idArticleItemArticle,
      textItemArticle: itemArticle.textItemArticle,
      imagesIdItemArticle: itemArticle.imagesIdItemArticle,
      dateCreatedItemArticle: itemArticle.dateCreatedItemArticle,
    );
  }

  factory ItemArticlePlain.fromJson(Map<String, dynamic> json) => ItemArticlePlain(
        idItemArticle: json["id_item_article"],
        idArticleItemArticle: json["id_article_item_article"],
        textItemArticle: json["text_item_article"],
        imagesIdItemArticle: json["images_id_item_article"],
        dateCreatedItemArticle: (json["date_created_item_article"]),
      );

  Map<String, dynamic> toJson() => {
        "id_item_article": idItemArticle,
        "id_article_item_article": idArticleItemArticle,
        "text_item_article": textItemArticle,
        "images_id_item_article": imagesIdItemArticle,
        "date_created_item_article": dateCreatedItemArticle,
      };

  @override
  String toString() {
    String cadena = '';

    cadena = '$cadena ItemArticle { ';
    cadena = '$cadena idItemArticle $idItemArticle';
    cadena = '$cadena idArticleItemArticle $idArticleItemArticle';
    cadena = '$cadena textItemArticle $textItemArticle';
    cadena = '$cadena imagesIdItemArticle ${imagesIdItemArticle.toString()}';
    cadena = '$cadena dateCreatedItemArticle $dateCreatedItemArticle';
    return cadena;
  }

  factory ItemArticlePlain.clear() {
    return ItemArticlePlain(
      idItemArticle: 0,
      idArticleItemArticle: 0,
      textItemArticle: '',
      imagesIdItemArticle: 0,
      dateCreatedItemArticle: '',
    );
  }

  ItemArticlePlain copyWith({
    int? idItemArticle,
    int? idArticleItemArticle,
    String? textItemArticle,
    ImageArticle? imageItemArticle,
    int? imagesIdItemArticle,
    String? dateCreatedItemArticle,
  }) {
    return ItemArticlePlain(
      idItemArticle: idItemArticle ?? this.idItemArticle,
      idArticleItemArticle: idArticleItemArticle ?? this.idArticleItemArticle,
      textItemArticle: textItemArticle ?? this.textItemArticle,
      imagesIdItemArticle: imagesIdItemArticle ?? this.imagesIdItemArticle,
      dateCreatedItemArticle: dateCreatedItemArticle ?? this.dateCreatedItemArticle,
    );
  }
}
