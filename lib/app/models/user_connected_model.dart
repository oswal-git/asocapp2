import 'dart:convert';

UserConnectedListResponse userConnectedListResponseFromJson(String str) => UserConnectedListResponse.fromJson(json.decode(str));

String userConnectedListResponseToJson(UserConnectedListResponse data) => json.encode(data.toJson());

class UserConnectedListResponse {
  int status;
  String message;
  UserConnectedListResult result;

  UserConnectedListResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory UserConnectedListResponse.fromJson(Map<String, dynamic> json) => UserConnectedListResponse(
        status: json["status"],
        message: json["message"],
        result: UserConnectedListResult.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result.toJson(),
      };
}

class UserConnectedListResult {
  int numRecords;
  List<UserConnected> records;

  UserConnectedListResult({
    required this.numRecords,
    required this.records,
  });

  factory UserConnectedListResult.fromJson(Map<String, dynamic> json) => UserConnectedListResult(
        numRecords: json["num_records"],
        records: List<UserConnected>.from(json["records"].map((x) => UserConnected.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "num_records": numRecords,
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
      };
}

// UserConnected unique

UserConnectedResponse userConnectedResponseFromJson(String str) => UserConnectedResponse.fromJson(json.decode(str));

String userConnectedResponseToJson(UserConnectedResponse data) => json.encode(data.toJson());

class UserConnectedResponse {
  int status;
  String message;
  UserConnected result;

  UserConnectedResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory UserConnectedResponse.fromJson(Map<String, dynamic> json) => UserConnectedResponse(
        status: json["status"],
        message: json["message"],
        result: UserConnected.fromJson(json['result'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result.toJson(),
      };
}

class UserConnected {
  static String table = '';

  int idUser;
  int idAsociationUser;
  String userNameUser;
  String emailUser;
  int recoverPasswordUser;
  String tokenUser;
  int tokenExpUser;
  String questionUser;
  String answerUser;
  String profileUser;
  String statusUser;
  String nameUser;
  String lastNameUser;
  String avatarUser;
  String phoneUser;
  String dateDeletedUser;
  String dateCreatedUser;
  String dateUpdatedUser;
  int idAsocAdmin;
  String longNameAsoc;
  String shortNameAsoc;
  int timeNotificationsUser;
  String languageUser;

  UserConnected({
    this.idUser = 0,
    this.idAsociationUser = 0,
    this.userNameUser = '',
    this.emailUser = '',
    this.recoverPasswordUser = 0,
    this.tokenUser = '',
    this.tokenExpUser = 0,
    this.questionUser = '',
    this.answerUser = '',
    this.profileUser = '',
    this.statusUser = '',
    this.nameUser = '',
    this.lastNameUser = '',
    this.avatarUser = '',
    this.phoneUser = '',
    this.dateDeletedUser = '',
    this.dateCreatedUser = '',
    this.dateUpdatedUser = '',
    this.idAsocAdmin = 0,
    this.longNameAsoc = '',
    this.shortNameAsoc = '',
    this.timeNotificationsUser = 0,
    this.languageUser = 'es',
  });

  static UserConnected fromJson(Map<String, dynamic> json) {
    return UserConnected(
      idUser: json['idUser'],
      idAsociationUser: json['idAsociationUser'],
      userNameUser: json['userNameUser'],
      emailUser: json['emailUser'],
      recoverPasswordUser: json['recoverPasswordUser'],
      tokenUser: json['tokenUser'],
      tokenExpUser: json['tokenExpUser'],
      questionUser: json['questionUser'],
      answerUser: json['answerUser'],
      profileUser: json['profileUser'],
      statusUser: json['statusUser'],
      nameUser: json['nameUser'],
      lastNameUser: json['lastNameUser'],
      avatarUser: json['avatarUser'],
      phoneUser: json['phoneUser'],
      dateDeletedUser: json['dateDeletedUser'],
      dateCreatedUser: json['dateCreatedUser'],
      dateUpdatedUser: json['dateUpdatedUser'],
      idAsocAdmin: ['superadmin', 'admin'].contains(json['profileUser']) ? json['idAsociationUser'] : 0,
      longNameAsoc: json['longNameAsoc'],
      shortNameAsoc: json['shortNameAsoc'],
      timeNotificationsUser: json['timeNotificationsUser'],
      languageUser: json['languageUser'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> toJson = {
      'idUser': idUser,
      'idAsociationUser': idAsociationUser,
      'userNameUser': userNameUser,
      'emailUser': emailUser,
      'recoverPasswordUser': recoverPasswordUser,
      'tokenUser': tokenUser,
      'tokenExpUser': tokenExpUser,
      'questionUser': questionUser,
      'answerUser': answerUser,
      'profileUser': profileUser,
      'statusUser': statusUser,
      'nameUser': nameUser,
      'lastNameUser': lastNameUser,
      'avatarUser': avatarUser,
      'phoneUser': phoneUser,
      'dateDeletedUser': dateDeletedUser,
      'dateCreatedUser': dateCreatedUser,
      'dateUpdatedUser': dateUpdatedUser,
      'idAsocAdmin': idAsocAdmin,
      'longNameAsoc': longNameAsoc,
      'shortNameAsoc': shortNameAsoc,
      'timeNotificationsUser': timeNotificationsUser,
      'languageUser': languageUser,
    };

    return toJson;
  }

  @override
  String toString() {
    String cadena = '';

    cadena = '$cadena UserConnected { ';
    cadena = '$cadena idUser: $idUser,';
    cadena = '$cadena idAsociationUser: ${idAsociationUser.toString()},';
    cadena = '$cadena userNameUser: $userNameUser,';
    cadena = '$cadena emailUser: $emailUser,';
    cadena = '$cadena recoverPasswordUser: ${recoverPasswordUser.toString()},';
    cadena = '$cadena tokenUser: $tokenUser,';
    cadena = '$cadena tokenExpUser: ${tokenExpUser.toString()},';
    cadena = '$cadena questionUser: $questionUser,';
    cadena = '$cadena answerUser: $answerUser,';
    cadena = '$cadena profileUser: $profileUser,';
    cadena = '$cadena statusUser: $statusUser,';
    cadena = '$cadena nameUser: $nameUser,';
    cadena = '$cadena lastNameUser: $lastNameUser,';
    cadena = '$cadena avatarUser: $avatarUser,';
    cadena = '$cadena phoneUser: $phoneUser,';
    cadena = '$cadena dateDeletedUser: $dateDeletedUser,';
    cadena = '$cadena dateCreatedUser: $dateCreatedUser,';
    cadena = '$cadena dateUpdatedUser: $dateUpdatedUser,';
    cadena = '$cadena idAsocAdmin: ${idAsocAdmin.toString()},';
    cadena = '$cadena longNameAsoc: $longNameAsoc,';
    cadena = '$cadena shortNameAsoc: $shortNameAsoc,';
    cadena = '$cadena timeNotificationsUser: ${timeNotificationsUser.toString()},';
    cadena = '$cadena languageUser: $languageUser,';

    return cadena;
  }

  factory UserConnected.clear() => UserConnected(
        idUser: 0,
        idAsociationUser: 0,
        userNameUser: '',
        emailUser: '',
        recoverPasswordUser: 0,
        tokenUser: '',
        tokenExpUser: 0,
        questionUser: '',
        answerUser: '',
        profileUser: '',
        statusUser: '',
        nameUser: '',
        lastNameUser: '',
        avatarUser: '',
        phoneUser: '',
        dateDeletedUser: '',
        dateCreatedUser: '',
        dateUpdatedUser: '',
        idAsocAdmin: 0,
        longNameAsoc: '',
        shortNameAsoc: '',
        timeNotificationsUser: 0,
        languageUser: 'es',
      );

  UserConnected clone() => UserConnected(
        idUser: idUser,
        idAsociationUser: idAsociationUser,
        userNameUser: userNameUser,
        emailUser: emailUser,
        recoverPasswordUser: recoverPasswordUser,
        tokenUser: tokenUser,
        tokenExpUser: tokenExpUser,
        questionUser: questionUser,
        answerUser: answerUser,
        profileUser: profileUser,
        statusUser: statusUser,
        nameUser: nameUser,
        lastNameUser: lastNameUser,
        avatarUser: avatarUser,
        phoneUser: phoneUser,
        dateDeletedUser: dateDeletedUser,
        dateCreatedUser: dateCreatedUser,
        dateUpdatedUser: dateUpdatedUser,
        idAsocAdmin: idAsocAdmin,
        longNameAsoc: longNameAsoc,
        shortNameAsoc: shortNameAsoc,
        timeNotificationsUser: timeNotificationsUser,
        languageUser: languageUser,
      );

  UserConnected copyWith({
    int? idUser,
    int? idAsociationUser,
    String? userNameUser,
    String? emailUser,
    int? recoverPasswordUser,
    String? tokenUser,
    int? tokenExpUser,
    String? questionUser,
    String? answerUser,
    String? profileUser,
    String? statusUser,
    String? nameUser,
    String? lastNameUser,
    String? avatarUser,
    String? phoneUser,
    String? dateDeletedUser,
    String? dateCreatedUser,
    String? dateUpdatedUser,
    int? idAsocAdmin,
    String? longNameAsoc,
    String? shortNameAsoc,
    int? timeNotificationsUser,
    String? languageUser,
  }) {
    return UserConnected(
      idUser: idUser ?? this.idUser,
      idAsociationUser: idAsociationUser ?? this.idAsociationUser,
      userNameUser: userNameUser ?? this.userNameUser,
      emailUser: emailUser ?? this.emailUser,
      recoverPasswordUser: recoverPasswordUser ?? this.recoverPasswordUser,
      tokenUser: tokenUser ?? this.tokenUser,
      tokenExpUser: tokenExpUser ?? this.tokenExpUser,
      questionUser: questionUser ?? this.questionUser,
      answerUser: answerUser ?? this.answerUser,
      profileUser: profileUser ?? this.profileUser,
      statusUser: statusUser ?? this.statusUser,
      nameUser: nameUser ?? this.nameUser,
      lastNameUser: lastNameUser ?? this.lastNameUser,
      avatarUser: avatarUser ?? this.avatarUser,
      phoneUser: phoneUser ?? this.phoneUser,
      dateDeletedUser: dateDeletedUser ?? this.dateDeletedUser,
      dateCreatedUser: dateCreatedUser ?? this.dateCreatedUser,
      dateUpdatedUser: dateUpdatedUser ?? this.dateUpdatedUser,
      idAsocAdmin: idAsocAdmin ?? this.idAsocAdmin,
      longNameAsoc: longNameAsoc ?? this.longNameAsoc,
      shortNameAsoc: shortNameAsoc ?? this.shortNameAsoc,
      timeNotificationsUser: timeNotificationsUser ?? this.timeNotificationsUser,
      languageUser: languageUser ?? this.languageUser,
    );
  }
}
