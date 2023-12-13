import 'dart:convert';

import 'package:intl/intl.dart';

ArticleListResponse articleListResponseFromJson(String str) => ArticleListResponse.fromJson(json.decode(str));

String articleListResponseToJson(ArticleListResponse data) => json.encode(data.toJson());

class ArticleListResponse {
  int status;
  String message;
  List<Article> result;

  ArticleListResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory ArticleListResponse.fromJson(Map<String, dynamic> json) => ArticleListResponse(
        status: json["status"],
        message: json["message"],
        result: List<Article>.from(json["result"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": List<Article>.from(result.map((x) => x.toJson())),
      };
}
// **************************************************

class ArticleListResult {
  int numRecords;
  List<Article> records;

  ArticleListResult({
    required this.numRecords,
    required this.records,
  });

  factory ArticleListResult.fromJson(Map<String, dynamic> json) => ArticleListResult(
        numRecords: json["num_records"],
        records: List<Article>.from(json["records"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "num_records": numRecords,
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
      };
}

// **************************************************
class Article {
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
  ImageArticle coverImageArticle;
  String titleArticle;
  String abstractArticle;
  String ubicationArticle;
  String dateDeletedArticle;
  String dateCreatedArticle;
  String dateUpdatedArticle;
  int idUser;
  int idAsociationUser;
  String emailUser;
  String profileUser;
  String nameUser;
  String lastNameUser;
  String avatarUser;
  String longNameAsociation;
  String shortNameAsociation;
  List<ItemArticle> itemsArticle;

  Article({
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
    required this.coverImageArticle,
    required this.titleArticle,
    required this.abstractArticle,
    required this.ubicationArticle,
    required this.dateDeletedArticle,
    required this.dateCreatedArticle,
    required this.dateUpdatedArticle,
    required this.idUser,
    required this.idAsociationUser,
    required this.emailUser,
    required this.profileUser,
    required this.nameUser,
    required this.lastNameUser,
    required this.avatarUser,
    required this.longNameAsociation,
    required this.shortNameAsociation,
    required this.itemsArticle,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        idArticle: int.parse(json["id_article"]),
        idAsociationArticle: int.parse(json["id_asociation_article"]),
        idUserArticle: int.parse(json["id_user_article"]),
        categoryArticle: json["category_article"],
        subcategoryArticle: json["subcategory_article"],
        classArticle: json["class_article"],
        stateArticle: json["state_article"],
        publicationDateArticle: (json["publication_date_article"]),
        effectiveDateArticle: (json["effective_date_article"]),
        expirationDateArticle: json["expiration_date_article"],
        coverImageArticle: ImageArticle.fromJson(json["cover_image_article"]),
        titleArticle: json["title_article"],
        abstractArticle: json["abstract_article"],
        ubicationArticle: json["ubication_article"],
        dateDeletedArticle: json["date_deleted_article"],
        dateCreatedArticle: (json["date_created_article"]),
        dateUpdatedArticle: (json["date_updated_article"]),
        idUser: int.parse(json["id_user"]),
        idAsociationUser: int.parse(json["id_asociation_user"]),
        emailUser: json["email_user"],
        profileUser: json["profile_user"],
        nameUser: json["name_user"],
        lastNameUser: json["last_name_user"],
        avatarUser: json["avatar_user"],
        longNameAsociation: json["long_name_asociation"],
        shortNameAsociation: json["short_name_asociation"],
        itemsArticle: List<ItemArticle>.from(json["items_article"].map((x) => ItemArticle.fromJson(x))),
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
      "cover_image_article": coverImageArticle.toJson(),
      "title_article": titleArticle,
      "abstract_article": abstractArticle,
      "ubication_article": ubicationArticle,
      "date_deleted_article": dateDeletedArticle,
      "date_created_article": dateCreatedArticle,
      "date_updated_article": dateUpdatedArticle,
      "id_user": idUser,
      "id_asociation_user": idAsociationUser,
      "email_user": emailUser,
      "profile_user": profileUser,
      "name_user": nameUser,
      "last_name_user": lastNameUser,
      "avatar_user": avatarUser,
      "long_name_asociation": longNameAsociation,
      "short_name_asociation": shortNameAsociation,
      "items_article": List<dynamic>.from(itemsArticle.map((x) => x.toJson())),
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
    cadena = '$cadena coverImageArticle: $coverImageArticle,';
    cadena = '$cadena titleArticle: $titleArticle,';
    cadena = '$cadena abstractArticle: $abstractArticle,';
    cadena = '$cadena ubicationArticle: $ubicationArticle,';
    cadena = '$cadena dateDeletedArticle: $dateDeletedArticle,';
    cadena = '$cadena dateCreatedArticle: $dateCreatedArticle,';
    cadena = '$cadena dateUpdatedArticle: $dateUpdatedArticle,';
    cadena = '$cadena idUser: $idUser,';
    cadena = '$cadena idAsociationUser: $idAsociationUser,';
    cadena = '$cadena emailUser: $emailUser,';
    cadena = '$cadena profileUser: $profileUser,';
    cadena = '$cadena nameUser: $nameUser,';
    cadena = '$cadena lastNameUser: $lastNameUser,';
    cadena = '$cadena avatarUser: $avatarUser,';
    cadena = '$cadena longNameAsociation: $longNameAsociation,';
    cadena = '$cadena shortNameAsociation: $shortNameAsociation,';
    itemsArticle.map((e) {
      cadena = '$cadena itemsArticle[${e.idItemArticle}]: ${e.toString()},';
      return;
    });

    return cadena;
  }

  factory Article.clear() {
    return Article(
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
      coverImageArticle: ImageArticle.clear(),
      titleArticle: '',
      abstractArticle: '',
      ubicationArticle: '',
      dateDeletedArticle: '',
      dateCreatedArticle: '',
      dateUpdatedArticle: '',
      idUser: 0,
      idAsociationUser: 0,
      emailUser: '',
      profileUser: '',
      nameUser: '',
      lastNameUser: '',
      avatarUser: '',
      longNameAsociation: '',
      shortNameAsociation: '',
      itemsArticle: [],
    );
  }

  Article copyWith({
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
    int? idUser,
    int? idAsociationUser,
    String? emailUser,
    String? profileUser,
    String? nameUser,
    String? lastNameUser,
    String? avatarUser,
    String? longNameAsociation,
    String? shortNameAsociation,
    List<ItemArticle>? itemsArticle,
  }) {
    return Article(
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
      coverImageArticle: coverImageArticle ?? this.coverImageArticle,
      titleArticle: titleArticle ?? this.titleArticle,
      abstractArticle: abstractArticle ?? this.abstractArticle,
      ubicationArticle: ubicationArticle ?? this.ubicationArticle,
      dateDeletedArticle: dateDeletedArticle ?? this.dateDeletedArticle,
      dateCreatedArticle: dateCreatedArticle ?? this.dateCreatedArticle,
      dateUpdatedArticle: dateUpdatedArticle ?? this.dateUpdatedArticle,
      idUser: idUser ?? this.idUser,
      idAsociationUser: idAsociationUser ?? this.idAsociationUser,
      emailUser: emailUser ?? this.emailUser,
      profileUser: profileUser ?? this.profileUser,
      nameUser: nameUser ?? this.nameUser,
      lastNameUser: lastNameUser ?? this.lastNameUser,
      avatarUser: avatarUser ?? this.avatarUser,
      longNameAsociation: longNameAsociation ?? this.longNameAsociation,
      shortNameAsociation: shortNameAsociation ?? this.shortNameAsociation,
      itemsArticle: itemsArticle ?? this.itemsArticle,
    );
  }
}

class ImageArticle {
  ImageArticle({
    required this.src,
    required this.nameFile,
    required this.filePath,
    this.fileImage,
    required this.isSelectedFile,
    required this.isDefault,
    required this.isChange,
  });

  String src;
  String nameFile;
  String filePath;
  dynamic fileImage;
  bool isSelectedFile;
  bool isDefault;
  bool isChange;

  factory ImageArticle.fromJson(Map<String, dynamic> json) => ImageArticle(
        src: json["src"],
        nameFile: json["nameFile"],
        filePath: json["filePath"],
        fileImage: json["fileImage"],
        isSelectedFile: json["isSelectedFile"],
        isDefault: json["isDefault"],
        isChange: json["isChange"],
      );

  Map<String, dynamic> toJson() => {
        "src": src,
        "nameFile": nameFile,
        "filePath": filePath,
        "fileImage": fileImage,
        "isSelectedFile": isSelectedFile,
        "isDefault": isDefault,
        "isChange": isChange,
      };

  @override
  String toString() {
    String cadena = '';

    cadena = '$cadena ImageArticle { ';
    cadena = '$cadena src $src';
    cadena = '$cadena nameFile $nameFile';
    cadena = '$cadena filePath $filePath';
    cadena = '$cadena fileImage $fileImage';
    cadena = '$cadena isSelectedFile $isSelectedFile';
    cadena = '$cadena isDefault $isDefault';
    cadena = '$cadena isChange $isChange';

    return cadena;
  }

  factory ImageArticle.clear() {
    return ImageArticle(
      src: '',
      nameFile: '',
      filePath: '',
      fileImage: '',
      isSelectedFile: false,
      isDefault: false,
      isChange: false,
    );
  }
}

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

// **************************************************

ArticleResponse articleResponseFromJson(String str) => ArticleResponse.fromJson(json.decode(str));

String articleResponseToJson(ArticleResponse data) => json.encode(data.toJson());

class ArticleResponse {
  int status;
  String message;
  Article result;

  ArticleResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory ArticleResponse.fromJson(Map<String, dynamic> json) => ArticleResponse(
        status: json["status"],
        message: json["message"],
        result: json["result"] == null ? Article.clear() : Article.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result.toJson(),
      };
}

// **************************************************
