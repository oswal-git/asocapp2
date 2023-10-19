// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserListResponse userListResponseFromJson(String str) => UserListResponse.fromJson(json.decode(str));

String userListResponseToJson(UserListResponse data) => json.encode(data.toJson());

class UserListResponse {
  int status;
  String message;
  UserListResult result;

  UserListResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory UserListResponse.fromJson(Map<String, dynamic> json) => UserListResponse(
        status: json["status"],
        message: json["message"],
        result: UserListResult.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result.toJson(),
      };
}

class UserListResult {
  int numRecords;
  List<User> records;

  UserListResult({
    required this.numRecords,
    required this.records,
  });

  factory UserListResult.fromJson(Map<String, dynamic> json) => UserListResult(
        numRecords: json["num_records"],
        records: List<User>.from(json["records"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "num_records": numRecords,
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
      };
}

// User unique

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  int status;
  String message;
  User result;

  UserResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        status: json["status"],
        message: json["message"],
        result: User.fromJson(json['result'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result.toJson(),
      };
}

class User {
  static String table = '';

  int idUser;
  int idAsociationUser;
  String userNameUser;
  String emailUser;
  String passwordUser;
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

  User({
    required this.idUser,
    required this.idAsociationUser,
    required this.userNameUser,
    required this.emailUser,
    required this.passwordUser,
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
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        idUser: json['id_user'],
        idAsociationUser: json['id_asociation_user'],
        userNameUser: json['user_name_user'],
        emailUser: json['email_user'],
        passwordUser: json['password_user'],
        recoverPasswordUser: json['recover_password_user'],
        tokenUser: json['token_user'],
        tokenExpUser: json['token_exp_user'],
        profileUser: json['profile_user'],
        statusUser: json['status_user'],
        nameUser: json['name_user'],
        lastNameUser: json['last_name_user'],
        avatarUser: json['avatar_user'],
        phoneUser: json['phone_user'],
        dateDeletedUser: json['date_deleted_user'],
        dateCreatedUser: json['date_created_user'],
        dateUpdatedUser: json['date_updated_user'],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> toJson = {
      'id_user': idUser,
      'id_asociation_user': idAsociationUser,
      'user_name_user': userNameUser,
      'email_user': emailUser,
      'password_user': passwordUser,
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
    };

    return toJson;
  }

  @override
  String toString() {
    String cadena = '';

    cadena = '$cadena User { ';
    cadena = '$cadena idUser: $idUser,';
    cadena = '$cadena idAsociationUser: $idAsociationUser,';
    cadena = '$cadena userNameUser: $userNameUser,';
    cadena = '$cadena emailUser: $emailUser,';
    cadena = '$cadena passwordUser: $passwordUser,';
    cadena = '$cadena recoverPasswordUser: $recoverPasswordUser,';
    cadena = '$cadena tokenUser: $tokenUser,';
    cadena = '$cadena tokenExpUser: $tokenExpUser,';
    cadena = '$cadena profileUser: $profileUser,';
    cadena = '$cadena statusUser: $statusUser,';
    cadena = '$cadena nameUser: $nameUser,';
    cadena = '$cadena lastNameUser: $lastNameUser,';
    cadena = '$cadena avatarUser: $avatarUser,';
    cadena = '$cadena phoneUser: $phoneUser,';
    cadena = '$cadena dateDeletedUser: $dateDeletedUser,';
    cadena = '$cadena dateCreatedUser: $dateCreatedUser,';
    cadena = '$cadena dateUpdatedUser: $dateUpdatedUser,';

    return cadena;
  }

  factory User.clear() {
    return User(
      idUser: 0,
      idAsociationUser: 0,
      userNameUser: '',
      emailUser: '',
      passwordUser: '',
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
    );
  }

  User copyWith({
    int? idUser,
    int? idAsociationUser,
    String? userNameUser,
    String? emailUser,
    String? passwordUser,
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
  }) {
    return User(
      idUser: idUser ?? this.idUser,
      idAsociationUser: idAsociationUser ?? this.idAsociationUser,
      userNameUser: userNameUser ?? this.userNameUser,
      emailUser: emailUser ?? this.emailUser,
      passwordUser: passwordUser ?? this.passwordUser,
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
    );
  }
}

// ************************************************************************************************
// User new password
// ************************************************************************************************

UserPassResponse userPassResponseFromJson(String str) => UserPassResponse.fromJson(json.decode(str));

String userPassResponseToJson(UserPassResponse data) => json.encode(data.toJson());

class UserPassResponse {
  int status;
  String message;
  UserPass result;

  UserPassResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory UserPassResponse.fromJson(Map<String, dynamic> json) => UserPassResponse(
        status: json["status"],
        message: json["message"],
        result: UserPass.fromJson(json['result'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result.toJson(),
      };
}

class UserPass {
  static String table = '';

  String passwordUser;
  String avatarUser;

  UserPass({
    required this.passwordUser,
    required this.avatarUser,
  });

  factory UserPass.fromJson(Map<String, dynamic> json) => UserPass(
        passwordUser: json['password_user'],
        avatarUser: json['avatar_user'],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> toJson = {
      'password_user': passwordUser,
      'avatar_user': avatarUser,
    };

    return toJson;
  }

  @override
  String toString() {
    String cadena = '';

    cadena = '$cadena UserPass { ';
    cadena = '$cadena passwordUser: $passwordUser,';
    cadena = '$cadena avatarUser: $avatarUser,';

    return cadena;
  }

  factory UserPass.clear() {
    return UserPass(
      passwordUser: '',
      avatarUser: '',
    );
  }

  UserPass copyWith({
    String? passwordUser,
    String? avatarUser,
  }) {
    return UserPass(
      passwordUser: passwordUser ?? this.passwordUser,
      avatarUser: avatarUser ?? this.avatarUser,
    );
  }
}

// ************************************************************************************************
// User reset password
// ************************************************************************************************

UserResetResponse userResetResponseFromJson(String str) => UserResetResponse.fromJson(json.decode(str));

String userResetResponseToJson(UserResetResponse data) => json.encode(data.toJson());

class UserResetResponse {
  int status;
  String message;
  UserReset result;

  UserResetResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory UserResetResponse.fromJson(Map<String, dynamic> json) => UserResetResponse(
        status: json["status"],
        message: json["message"],
        result: UserReset.fromJson(json['result'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result.toJson(),
      };
}

class UserReset {
  static String table = '';

  String passwordUser;
  String avatarUser;

  UserReset({
    required this.passwordUser,
    required this.avatarUser,
  });

  factory UserReset.fromJson(Map<String, dynamic> json) => UserReset(
        passwordUser: json['password_user'],
        avatarUser: json['avatar_user'],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> toJson = {
      'password_user': passwordUser,
      'avatar_user': avatarUser,
    };

    return toJson;
  }

  @override
  String toString() {
    String cadena = '';

    cadena = '$cadena UserReset { ';
    cadena = '$cadena passwordUser: $passwordUser,';
    cadena = '$cadena avatarUser: $avatarUser,';

    return cadena;
  }

  factory UserReset.clear() {
    return UserReset(
      passwordUser: '',
      avatarUser: '',
    );
  }

  UserReset copyWith({
    String? passwordUser,
    String? avatarUser,
  }) {
    return UserReset(
      passwordUser: passwordUser ?? this.passwordUser,
      avatarUser: avatarUser ?? this.avatarUser,
    );
  }
}
