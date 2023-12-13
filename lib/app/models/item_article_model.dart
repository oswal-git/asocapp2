import 'dart:convert';

import 'package:asocapp/app/models/image_article_model.dart';

ItemArticle articleRequestFromJson(String str) => ItemArticle.fromJson(json.decode(str));

String articleRequestToJson(ItemArticle data) => json.encode(data.toJson());

class ItemArticle {
  ItemArticle({
    required this.idItemArticle,
    required this.idArticleItemArticle,
    required this.textItemArticle,
    required this.imageItemArticle,
    required this.dateCreatedItemArticle,
  });

  int idItemArticle;
  int idArticleItemArticle;
  String textItemArticle;
  ImageArticle imageItemArticle;
  String dateCreatedItemArticle;

  factory ItemArticle.fromJson(Map<String, dynamic> json) => ItemArticle(
        idItemArticle: int.parse(json["id_item_article"]),
        idArticleItemArticle: int.parse(json["id_article_item_article"]),
        textItemArticle: json["text_item_article"],
        imageItemArticle: ImageArticle.fromJson(json["image_item_article"]),
        dateCreatedItemArticle: (json["date_created_item_article"]),
      );

  Map<String, dynamic> toJson() => {
        "id_item_article": idItemArticle,
        "id_article_item_article": idArticleItemArticle,
        "text_item_article": textItemArticle,
        "image_item_article": imageItemArticle.toJson(),
        "date_created_item_article": dateCreatedItemArticle,
      };

  @override
  String toString() {
    String cadena = '';

    cadena = '$cadena ItemArticle { ';
    cadena = '$cadena idItemArticle $idItemArticle';
    cadena = '$cadena idArticleItemArticle $idArticleItemArticle';
    cadena = '$cadena textItemArticle $textItemArticle';
    cadena = '$cadena imageItemArticle ${imageItemArticle.toString()}';
    cadena = '$cadena dateCreatedItemArticle $dateCreatedItemArticle';
    return cadena;
  }

  factory ItemArticle.clear() {
    return ItemArticle(
      idItemArticle: 0,
      idArticleItemArticle: 0,
      textItemArticle: '',
      imageItemArticle: ImageArticle.clear(),
      dateCreatedItemArticle: '',
    );
  }

  ItemArticle copyWith({
    int? idItemArticle,
    int? idArticleItemArticle,
    String? textItemArticle,
    ImageArticle? imageItemArticle,
    String? dateCreatedItemArticle,
  }) {
    return ItemArticle(
      idItemArticle: idItemArticle ?? this.idItemArticle,
      idArticleItemArticle: idArticleItemArticle ?? this.idArticleItemArticle,
      textItemArticle: textItemArticle ?? this.textItemArticle,
      imageItemArticle: imageItemArticle ?? this.imageItemArticle,
      dateCreatedItemArticle: dateCreatedItemArticle ?? this.dateCreatedItemArticle,
    );
  }
}
