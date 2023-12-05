import 'dart:convert';

UsersListResponse usersListUserResponseFromJson(String str) => UsersListResponse.fromJson(json.decode(str));

String usersListUserResponseToJson(UsersListResponse data) => json.encode(data.toJson());

class UsersListResponse {
  int status;
  String message;
  UsersListResult result;

  UsersListResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory UsersListResponse.fromJson(Map<String, dynamic> json) => UsersListResponse(
        status: json['status'],
        message: json['message'],
        result: UsersListResult.fromJson(json['result']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result.toJson(),
      };
}

class UsersListResult {
  int numRecords;
  List<UserItem> records;

  UsersListResult({
    required this.numRecords,
    required this.records,
  });

  factory UsersListResult.fromJson(Map<String, dynamic> json) => UsersListResult(
        numRecords: json['num_records'],
        records: List<UserItem>.from(json["records"].map((x) => UserItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'num_records': numRecords,
        'records': records.map((v) => v.toJson()).toList(),
      };
}

class UserItem {
  int idUser;
  int idAsociationUser;
  String userNameUser;
  String emailUser;
  int recoverPasswordUser;
  String tokenUser;
  int tokenExpUser;
  String profileUser;
  String statusUser;
  String nameUser;
  String lastNameUser;
  String avatarUser;
  String phoneUser;
  String dateDeletedUser;
  String dateCreatedUser;
  String dateUpdatedUser;
  String languageUser;
  String longNameAsociation;
  String shortNameAsociation;
  String logoAsociation;
  String emailAsociation;
  String nameContactAsociation;
  String phoneAsociation;

  UserItem({
    this.idUser = 0,
    this.idAsociationUser = 0,
    this.userNameUser = '',
    this.emailUser = '',
    this.recoverPasswordUser = 0,
    this.tokenUser = '',
    this.tokenExpUser = 0,
    this.profileUser = '',
    this.statusUser = '',
    this.nameUser = '',
    this.lastNameUser = '',
    this.avatarUser = '',
    this.phoneUser = '',
    this.dateDeletedUser = '',
    this.dateCreatedUser = '',
    this.dateUpdatedUser = '',
    this.languageUser = '',
    this.longNameAsociation = '',
    this.shortNameAsociation = '',
    this.logoAsociation = '',
    this.emailAsociation = '',
    this.nameContactAsociation = '',
    this.phoneAsociation = '',
  });

  static UserItem fromJson(Map<String, dynamic> json) => UserItem(
        idUser: int.parse(json["id_user"]),
        idAsociationUser: int.parse(json["id_asociation_user"]),
        userNameUser: json['user_name_user'],
        emailUser: json['email_user'],
        recoverPasswordUser: int.parse(json['recover_password_user']),
        tokenUser: json['token_user'],
        tokenExpUser: int.parse(json['token_exp_user']),
        profileUser: json['profile_user'],
        statusUser: json['status_user'],
        nameUser: json['name_user'],
        lastNameUser: json['last_name_user'],
        avatarUser: json['avatar_user'],
        phoneUser: json['phone_user'],
        dateDeletedUser: json['date_deleted_user'],
        dateCreatedUser: json['date_created_user'],
        dateUpdatedUser: json['date_updated_user'],
        languageUser: json['language_user'],
        longNameAsociation: json['long_name_asociation'],
        shortNameAsociation: json['short_name_asociation'],
        logoAsociation: json['logo_asociation'],
        emailAsociation: json['email_asociation'],
        nameContactAsociation: json['name_contact_asociation'],
        phoneAsociation: json['phone_asociation'],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> toJson = {
      'id_user': idUser,
      'id_asociation_user': idAsociationUser,
      'user_name_user': userNameUser,
      'email_user': emailUser,
      'recover_password_user': recoverPasswordUser,
      'token_user': tokenUser,
      'token_exp_user': tokenExpUser,
      'profile_user': profileUser,
      'status_user': statusUser,
      'name_user': nameUser,
      'last_name_user': lastNameUser,
      'avatar_user': avatarUser,
      'phone_user': phoneUser,
      'date_deleted_user': dateDeletedUser,
      'date_created_user': dateCreatedUser,
      'date_updated_user': dateUpdatedUser,
      'language_user': languageUser,
      'long_name_asociation': longNameAsociation,
      'short_name_asociation': shortNameAsociation,
      'logo_asociation': logoAsociation,
      'email_asociation': emailAsociation,
      'name_contact_asociation': nameContactAsociation,
      'phone_asociation': phoneAsociation,
    };

    return toJson;
  }

  @override
  String toString() {
    String cadena = '';

    cadena = '$cadena UserItem { ';
    cadena = '$cadena idUser: $idUser,';
    cadena = '$cadena idAsociationUser: ${idAsociationUser.toString()},';
    cadena = '$cadena userNameUser: $userNameUser,';
    cadena = '$cadena emailUser: $emailUser,';
    cadena = '$cadena recoverPasswordUser: ${recoverPasswordUser.toString()},';
    cadena = '$cadena tokenUser: $tokenUser,';
    cadena = '$cadena tokenExpUser: ${tokenExpUser.toString()},';
    cadena = '$cadena profileUser: $profileUser,';
    cadena = '$cadena statusUser: $statusUser,';
    cadena = '$cadena nameUser: $nameUser,';
    cadena = '$cadena lastNameUser: $lastNameUser,';
    cadena = '$cadena avatarUser: $avatarUser,';
    cadena = '$cadena phoneUser: $phoneUser,';
    cadena = '$cadena dateDeletedUser: $dateDeletedUser,';
    cadena = '$cadena dateCreatedUser: $dateCreatedUser,';
    cadena = '$cadena dateUpdatedUser: $dateUpdatedUser,';
    cadena = '$cadena languageUser: $languageUser,';
    cadena = '$cadena longNameAsociation: $longNameAsociation,';
    cadena = '$cadena shortNameAsociation: $shortNameAsociation,';
    cadena = '$cadena logoAsociation: $logoAsociation,';
    cadena = '$cadena emailAsociation: $emailAsociation,';
    cadena = '$cadena nameContactAsociation: $nameContactAsociation,';
    cadena = '$cadena phoneAsociation: $phoneAsociation,';

    return cadena;
  }

  factory UserItem.clear() => UserItem(
        idUser: 0,
        idAsociationUser: 0,
        userNameUser: '',
        emailUser: '',
        recoverPasswordUser: 0,
        tokenUser: '',
        tokenExpUser: 0,
        profileUser: '',
        statusUser: '',
        nameUser: '',
        lastNameUser: '',
        avatarUser: '',
        phoneUser: '',
        dateDeletedUser: '',
        dateCreatedUser: '',
        dateUpdatedUser: '',
        languageUser: 'es',
        longNameAsociation: '',
        shortNameAsociation: '',
        logoAsociation: '',
        emailAsociation: '',
        nameContactAsociation: '',
        phoneAsociation: '',
      );

  UserItem clone() => UserItem(
        idUser: idUser,
        idAsociationUser: idAsociationUser,
        userNameUser: userNameUser,
        emailUser: emailUser,
        recoverPasswordUser: recoverPasswordUser,
        tokenUser: tokenUser,
        tokenExpUser: tokenExpUser,
        profileUser: profileUser,
        statusUser: statusUser,
        nameUser: nameUser,
        lastNameUser: lastNameUser,
        avatarUser: avatarUser,
        phoneUser: phoneUser,
        dateDeletedUser: dateDeletedUser,
        dateCreatedUser: dateCreatedUser,
        dateUpdatedUser: dateUpdatedUser,
        languageUser: languageUser,
        longNameAsociation: longNameAsociation,
        shortNameAsociation: shortNameAsociation,
        logoAsociation: logoAsociation,
        emailAsociation: emailAsociation,
        nameContactAsociation: nameContactAsociation,
        phoneAsociation: phoneAsociation,
      );

  UserItem copyWith({
    int? idUser,
    int? idAsociationUser,
    String? userNameUser,
    String? emailUser,
    int? recoverPasswordUser,
    String? tokenUser,
    int? tokenExpUser,
    String? profileUser,
    String? statusUser,
    String? nameUser,
    String? lastNameUser,
    String? avatarUser,
    String? phoneUser,
    String? dateDeletedUser,
    String? dateCreatedUser,
    String? dateUpdatedUser,
    String? languageUser,
    String? longNameAsociation,
    String? shortNameAsociation,
    String? logoAsociation,
    String? emailAsociation,
    String? nameContactAsociation,
    String? phoneAsociation,
  }) {
    return UserItem(
      idUser: idUser ?? this.idUser,
      idAsociationUser: idAsociationUser ?? this.idAsociationUser,
      userNameUser: userNameUser ?? this.userNameUser,
      emailUser: emailUser ?? this.emailUser,
      recoverPasswordUser: recoverPasswordUser ?? this.recoverPasswordUser,
      tokenUser: tokenUser ?? this.tokenUser,
      tokenExpUser: tokenExpUser ?? this.tokenExpUser,
      profileUser: profileUser ?? this.profileUser,
      statusUser: statusUser ?? this.statusUser,
      nameUser: nameUser ?? this.nameUser,
      lastNameUser: lastNameUser ?? this.lastNameUser,
      avatarUser: avatarUser ?? this.avatarUser,
      phoneUser: phoneUser ?? this.phoneUser,
      dateDeletedUser: dateDeletedUser ?? this.dateDeletedUser,
      dateCreatedUser: dateCreatedUser ?? this.dateCreatedUser,
      dateUpdatedUser: dateUpdatedUser ?? this.dateUpdatedUser,
      languageUser: languageUser ?? this.languageUser,
      longNameAsociation: longNameAsociation ?? this.longNameAsociation,
      shortNameAsociation: shortNameAsociation ?? this.shortNameAsociation,
      logoAsociation: logoAsociation ?? this.logoAsociation,
      emailAsociation: emailAsociation ?? this.emailAsociation,
      nameContactAsociation: nameContactAsociation ?? this.nameContactAsociation,
      phoneAsociation: phoneAsociation ?? this.phoneAsociation,
    );
  }
}
