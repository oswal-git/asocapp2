import 'dart:convert';

import 'package:asocapp/app/models/image_article_model.dart';

ItemArticle itemArticleRequestFromJson(String str) => ItemArticle.fromJson(json.decode(str));

String itemArticleRequestToJson(ItemArticle data) => json.encode(data.toJson());

class ItemArticle {
  int idItemArticle;
  int idArticleItemArticle;
  String textItemArticle;
  ImageArticle imageItemArticle;
  int imagesIdItemArticle;
  String dateCreatedItemArticle;

  ItemArticle({
    required this.idItemArticle,
    required this.idArticleItemArticle,
    required this.textItemArticle,
    required this.imageItemArticle,
    required this.imagesIdItemArticle,
    required this.dateCreatedItemArticle,
  });

  factory ItemArticle.fromJson(Map<String, dynamic> json) => ItemArticle(
        idItemArticle: json["id_item_article"],
        idArticleItemArticle: json["id_article_item_article"],
        textItemArticle: json["text_item_article"],
        imageItemArticle: ImageArticle.fromJson(json["image_map_item_article"]),
        imagesIdItemArticle: json["images_id_item_article"],
        dateCreatedItemArticle: (json["date_created_item_article"]),
      );

  Map<String, dynamic> toJson() => {
        "id_item_article": idItemArticle,
        "id_article_item_article": idArticleItemArticle,
        "text_item_article": textItemArticle,
        "image_item_article": imageItemArticle.toJson(),
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
    cadena = '$cadena imageItemArticle ${imageItemArticle.toString()}';
    cadena = '$cadena imagesIdItemArticle ${imagesIdItemArticle.toString()}';
    cadena = '$cadena dateCreatedItemArticle $dateCreatedItemArticle';
    return cadena;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemArticle &&
          idItemArticle == other.idItemArticle &&
          idArticleItemArticle == other.idArticleItemArticle &&
          textItemArticle == other.textItemArticle &&
          imageItemArticle == other.imageItemArticle &&
          imagesIdItemArticle == other.imagesIdItemArticle &&
          dateCreatedItemArticle == other.dateCreatedItemArticle;

  @override
  int get hashCode =>
      idItemArticle.hashCode ^
      idArticleItemArticle.hashCode ^
      textItemArticle.hashCode ^
      imageItemArticle.hashCode ^
      imagesIdItemArticle.hashCode ^
      dateCreatedItemArticle.hashCode;

  factory ItemArticle.clear() {
    return ItemArticle(
      idItemArticle: 0,
      idArticleItemArticle: 0,
      textItemArticle: '',
      imageItemArticle: ImageArticle.clear(),
      imagesIdItemArticle: 0,
      dateCreatedItemArticle: '',
    );
  }

  ItemArticle copyWith({
    int? idItemArticle,
    int? idArticleItemArticle,
    String? textItemArticle,
    ImageArticle? imageItemArticle,
    int? imagesIdItemArticle,
    String? dateCreatedItemArticle,
  }) {
    return ItemArticle(
      idItemArticle: idItemArticle ?? this.idItemArticle,
      idArticleItemArticle: idArticleItemArticle ?? this.idArticleItemArticle,
      textItemArticle: textItemArticle ?? this.textItemArticle,
      imageItemArticle: imageItemArticle ?? this.imageItemArticle,
      imagesIdItemArticle: imagesIdItemArticle ?? this.imagesIdItemArticle,
      dateCreatedItemArticle: dateCreatedItemArticle ?? this.dateCreatedItemArticle,
    );
  }
}
