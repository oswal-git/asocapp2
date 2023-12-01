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

  UserItem(
      {required this.idUser,
      required this.idAsociationUser,
      required this.userNameUser,
      required this.emailUser,
      required this.recoverPasswordUser,
      required this.tokenUser,
      required this.tokenExpUser,
      required this.profileUser,
      required this.statusUser,
      required this.nameUser,
      required this.lastNameUser,
      required this.avatarUser,
      required this.phoneUser,
      required this.dateDeletedUser,
      required this.dateCreatedUser,
      required this.dateUpdatedUser,
      required this.languageUser,
      required this.longNameAsociation,
      required this.shortNameAsociation,
      required this.logoAsociation,
      required this.emailAsociation,
      required this.nameContactAsociation,
      required this.phoneAsociation});

  factory UserItem.fromJson(Map<String, dynamic> json) => UserItem(
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
}
