import 'dart:convert';

import 'package:asocapp/app/models/article_model.dart';
import 'package:asocapp/app/models/image_article_model.dart';
import 'package:asocapp/app/models/item_article_model.dart';
import 'package:asocapp/app/utils/utils.dart';

import 'package:intl/intl.dart';

ArticleListResponse articleListResponseFromJson(String str) => ArticleListResponse.fromJson(json.decode(str));

String articleListResponseToJson(ArticleListResponse data) => json.encode(data.toJson());

class ArticleListResponse {
  int status;
  String message;
  List<ArticleUser> result;

  ArticleListResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory ArticleListResponse.fromJson(Map<String, dynamic> json) => ArticleListResponse(
        status: json["status"],
        message: json["message"],
        result: json["result"] == null ? [] : List<ArticleUser>.from(json["result"].map((x) => ArticleUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": List<ArticleUser>.from(result.map((x) => x.toJson())),
      };
}
// **************************************************

class ArticleListResult {
  int numRecords;
  List<ArticleUser> records;

  ArticleListResult({
    required this.numRecords,
    required this.records,
  });

  factory ArticleListResult.fromJson(Map<String, dynamic> json) => ArticleListResult(
        numRecords: json["num_records"],
        records: List<ArticleUser>.from(json["records"].map((x) => ArticleUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "num_records": numRecords,
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
      };
}

// **************************************************
ArticleUserResponse articleUserResponseFromJson(String str) => ArticleUserResponse.fromJson(json.decode(str));

String articleUserResponseToJson(ArticleUserResponse data) => json.encode(data.toJson());

class ArticleUserResponse {
  int status;
  String message;
  ArticleUser result;

  ArticleUserResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory ArticleUserResponse.fromJson(Map<String, dynamic> json) => ArticleUserResponse(
        status: json["status"],
        message: json["message"],
        result: ArticleUser.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result.toJson(),
      };
}

class ArticleUser extends Article {
  final int numOrder;
  final int idUser;
  final int idAsociationUser;
  final String emailUser;
  final String profileUser;
  final String nameUser;
  final String lastNameUser;
  final String avatarUser;
  final String longNameAsociation;
  final String shortNameAsociation;

  ArticleUser({
    required super.idArticle,
    required super.idAsociationArticle,
    required super.idUserArticle,
    required super.categoryArticle,
    required super.subcategoryArticle,
    required super.classArticle,
    required super.stateArticle,
    required super.publicationDateArticle,
    required super.effectiveDateArticle,
    required super.expirationDateArticle,
    required super.coverImageArticle,
    required super.titleArticle,
    required super.abstractArticle,
    required super.ubicationArticle,
    required super.dateDeletedArticle,
    required super.dateCreatedArticle,
    required super.dateUpdatedArticle,
    required this.numOrder,
    required this.idUser,
    required this.idAsociationUser,
    required this.emailUser,
    required this.profileUser,
    required this.nameUser,
    required this.lastNameUser,
    required this.avatarUser,
    required this.longNameAsociation,
    required this.shortNameAsociation,
    required super.itemsArticle,
  });

  factory ArticleUser.fromArticle({
    required Article article,
    required int numOrder,
    required int idUser,
    required int idAsociationUser,
    required String emailUser,
    required String profileUser,
    required String nameUser,
    required String lastNameUser,
    required String avatarUser,
    required String longNameAsociation,
    required String shortNameAsociation,
  }) {
    return ArticleUser(
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
      coverImageArticle: article.coverImageArticle,
      titleArticle: article.titleArticle,
      abstractArticle: article.abstractArticle,
      ubicationArticle: article.ubicationArticle,
      dateDeletedArticle: article.dateDeletedArticle,
      dateCreatedArticle: article.dateCreatedArticle,
      dateUpdatedArticle: article.dateUpdatedArticle,
      numOrder: numOrder,
      idUser: idUser,
      idAsociationUser: idAsociationUser,
      emailUser: emailUser,
      profileUser: profileUser,
      nameUser: nameUser,
      lastNameUser: lastNameUser,
      avatarUser: avatarUser,
      longNameAsociation: longNameAsociation,
      shortNameAsociation: shortNameAsociation,
      itemsArticle: article.itemsArticle,
      // Proporciona otros valores específicos de ArticleUser aquí
    );
  }

  factory ArticleUser.fromJson(Map<String, dynamic> json) => ArticleUser(
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
        coverImageArticle: ImageArticle.fromJson(json["cover_image_article"]),
        titleArticle: json["title_article"],
        abstractArticle: json["abstract_article"],
        ubicationArticle: json["ubication_article"],
        dateDeletedArticle: json["date_deleted_article"],
        dateCreatedArticle: (json["date_created_article"]),
        dateUpdatedArticle: (json["date_updated_article"]),
        numOrder: json.containsKey("num_order") ? json["num_order"] : 0,
        idUser: json["id_user"],
        idAsociationUser: json["id_asociation_user"],
        emailUser: json["email_user"],
        profileUser: json["profile_user"],
        nameUser: json["name_user"],
        lastNameUser: json["last_name_user"],
        avatarUser: json["avatar_user"],
        longNameAsociation: json["long_name_asociation"],
        shortNameAsociation: json["short_name_asociation"],
        itemsArticle: List<ItemArticle>.from(json["items_article"].map((x) => ItemArticle.fromJson(x))),
      );

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> toJson = {
      ...super.toJson(),
      "num_order": numOrder,
      "id_user": idUser,
      "id_asociation_user": idAsociationUser,
      "email_user": emailUser,
      "profile_user": profileUser,
      "name_user": nameUser,
      "last_name_user": lastNameUser,
      "avatar_user": avatarUser,
      "long_name_asociation": longNameAsociation,
      "short_name_asociation": shortNameAsociation,
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
    cadena = '$cadena coverImageArticle: ${coverImageArticle.toString()},';
    cadena = '$cadena titleArticle: $titleArticle,';
    cadena = '$cadena abstractArticle: $abstractArticle,';
    cadena = '$cadena ubicationArticle: $ubicationArticle,';
    cadena = '$cadena dateDeletedArticle: $dateDeletedArticle,';
    cadena = '$cadena dateCreatedArticle: $dateCreatedArticle,';
    cadena = '$cadena dateUpdatedArticle: $dateUpdatedArticle,';
    cadena = '$cadena numOrder: $numOrder,';
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

  factory ArticleUser.clear() {
    return ArticleUser(
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
      numOrder: 0,
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

  @override
  ArticleUser copyWith({
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
    int? numOrder,
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
    return ArticleUser(
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
      numOrder: numOrder ?? this.numOrder,
      idUser: idUser ?? this.idUser,
      idAsociationUser: idAsociationUser ?? this.idAsociationUser,
      emailUser: emailUser ?? this.emailUser,
      profileUser: profileUser ?? this.profileUser,
      nameUser: nameUser ?? this.nameUser,
      lastNameUser: lastNameUser ?? this.lastNameUser,
      avatarUser: avatarUser ?? this.avatarUser,
      longNameAsociation: longNameAsociation ?? this.longNameAsociation,
      shortNameAsociation: shortNameAsociation ?? this.shortNameAsociation,
      itemsArticle: itemsArticle != null ? EglHelper.copyListItems(itemsArticle) : EglHelper.copyListItems(this.itemsArticle),
    );
  }
}

// **************************************************

ArticleResponse articleResponseFromJson(String str) => ArticleResponse.fromJson(json.decode(str));

String articleResponseToJson(ArticleResponse data) => json.encode(data.toJson());

class ArticleResponse {
  int status;
  String message;
  ArticleUser result;

  ArticleResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory ArticleResponse.fromJson(Map<String, dynamic> json) => ArticleResponse(
        status: json["status"],
        message: json["message"],
        result: json["result"] == null ? ArticleUser.clear() : ArticleUser.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result.toJson(),
      };
}

// **************************************************
