import 'dart:convert';

UserAsocResponse userAsocResponseFromJson(String str) => UserAsocResponse.fromJson(json.decode(str));

String userAsocResponseToJson(UserAsocResponse data) => json.encode(data.toJson());

class UserAsocResponse {
  final int status;
  final String message;
  final UserAsocResult? result;

  UserAsocResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory UserAsocResponse.fromJson(Map<String, dynamic> json) {
    return UserAsocResponse(
      status: json['status'] as int,
      message: json['message'] as String,
      result: UserAsocResult.fromJson(json['result']),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'status': status,
      'message': message,
      'result': result?.toJson(),
    };
  }

  UserAsocResponse copyWith({
    int? status,
    String? message,
    UserAsocResult? result,
  }) {
    return UserAsocResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      result: result ?? this.result,
    );
  }

  @override
  String toString() => 'UserAsocResponse(status: $status, message: $message, result: $result)';

  @override
  bool operator ==(covariant UserAsocResponse other) {
    if (identical(this, other)) return true;

    return other.status == status && other.message == message && other.result == result;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ result.hashCode;
}

class UserAsocResult {
  final DataUser dataUser;
  final DataAsoc dataAsoc;

  UserAsocResult({
    required this.dataUser,
    required this.dataAsoc,
  });

  factory UserAsocResult.fromJson(Map<String, dynamic> json) {
    return UserAsocResult(
      dataUser: DataUser.fromJson(json['data_user']),
      dataAsoc: DataAsoc.fromJson(json['data_asoc']),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'data_user': dataUser.toJson(),
      'data_asoc': dataAsoc.toJson(),
    };
  }

  UserAsocResult copyWith({
    DataUser? dataUser,
    DataAsoc? dataAsoc,
  }) {
    return UserAsocResult(
      dataUser: dataUser ?? this.dataUser,
      dataAsoc: dataAsoc ?? this.dataAsoc,
    );
  }

  @override
  String toString() => 'UserAsocResult(data_user: ${dataUser.toString()}, data_asoc: ${dataAsoc.toString()})';

  @override
  bool operator ==(covariant UserAsocResult other) {
    if (identical(this, other)) return true;

    return other.dataUser == dataUser && other.dataAsoc == dataAsoc;
  }

  @override
  int get hashCode => dataUser.hashCode ^ dataAsoc.hashCode;
}

class DataUser {
  final int idUser;
  final int idAsociationUser;
  final String userNameUser;
  final String emailUser;
  final String tokenUser;
  final int tokenExpUser;
  final int recoverPasswordUser;
  final String questionUser;
  final String answerUser;
  final String profileUser;
  final String statusUser;
  final String nameUser;
  final String lastNameUser;
  final String avatarUser;
  final String phoneUser;
  final String dateDeletedUser;
  final String dateCreatedUser;
  final String dateUpdatedUser;
  final int timeNotificationsUser;
  final String languageUser;

  DataUser({
    required this.idUser,
    required this.idAsociationUser,
    required this.userNameUser,
    required this.emailUser,
    required this.tokenUser,
    required this.tokenExpUser,
    required this.recoverPasswordUser,
    required this.questionUser,
    required this.answerUser,
    required this.profileUser,
    required this.statusUser,
    required this.nameUser,
    required this.lastNameUser,
    required this.avatarUser,
    required this.phoneUser,
    required this.dateDeletedUser,
    required this.dateCreatedUser,
    required this.dateUpdatedUser,
    required this.timeNotificationsUser,
    required this.languageUser,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id_user': idUser,
      'id_asociation_user': idAsociationUser,
      'user_name_user': userNameUser,
      'email_user': emailUser,
      'token_user': tokenUser,
      'token_exp_user': tokenExpUser,
      'recover_password_user': recoverPasswordUser,
      'question_user': questionUser,
      'answer_user': answerUser,
      'profile_user': profileUser,
      'status_user': statusUser,
      'name_user': nameUser,
      'last_name_user': lastNameUser,
      'avatar_user': avatarUser,
      'phone_user': phoneUser,
      'date_deleted_user': dateDeletedUser,
      'date_created_user': dateCreatedUser,
      'date_updated_user': dateUpdatedUser,
      'time_notifications_user': timeNotificationsUser,
      'language_user': languageUser,
    };
  }

  factory DataUser.fromJson(Map<String, dynamic> json) {
    return DataUser(
      idUser: json['id_user'].toInt() as int,
      idAsociationUser: json['id_asociation_user'].toInt() as int,
      userNameUser: json['user_name_user'] as String,
      emailUser: json['email_user'] as String,
      tokenUser: json['token_user'] as String,
      tokenExpUser: json['token_exp_user'].toInt() as int,
      recoverPasswordUser: json['recover_password_user'].toInt() as int,
      questionUser: json['question_user'] == null ? '' : json['question_user'] as String,
      answerUser: json['answer_user'] == null ? '' : json['answer_user'] as String,
      profileUser: json['profile_user'] as String,
      statusUser: json['status_user'] as String,
      nameUser: json['name_user'] as String,
      lastNameUser: json['last_name_user'] as String,
      avatarUser: json['avatar_user'] as String,
      phoneUser: json['phone_user'] as String,
      dateDeletedUser: json['date_deleted_user'] as String,
      dateCreatedUser: json['date_created_user'] as String,
      dateUpdatedUser: json['date_updated_user'] as String,
      timeNotificationsUser: json['time_notifications_user'].toInt() as int,
      languageUser: json['language_user'] as String,
    );
  }

  DataUser copyWith({
    int? idUser,
    int? idAsociationUser,
    String? userNameUser,
    String? emailUser,
    String? tokenUser,
    int? tokenExpUser,
    int? recoverPasswordUser,
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
    int? timeNotificationsUser,
    String? languageUser,
  }) {
    return DataUser(
      idUser: idUser ?? this.idUser,
      idAsociationUser: idAsociationUser ?? this.idAsociationUser,
      userNameUser: userNameUser ?? this.userNameUser,
      emailUser: emailUser ?? this.emailUser,
      tokenUser: tokenUser ?? this.tokenUser,
      tokenExpUser: tokenExpUser ?? this.tokenExpUser,
      recoverPasswordUser: recoverPasswordUser ?? this.recoverPasswordUser,
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
      timeNotificationsUser: timeNotificationsUser ?? this.timeNotificationsUser,
      languageUser: languageUser ?? this.languageUser,
    );
  }

  @override
  String toString() {
    return 'DataUser(idUser: $idUser, idAsociationUser: $idAsociationUser, userNameUser: $userNameUser, emailUser: $emailUser, tokenUser: $tokenUser, tokenExpUser: $tokenExpUser, recoverPasswordUser: $recoverPasswordUser, profileUser: $profileUser, statusUser: $statusUser, nameUser: $nameUser, lastNameUser: $lastNameUser, avatarUser: $avatarUser, phoneUser: $phoneUser, dateDeletedUser: $dateDeletedUser, dateCreatedUser: $dateCreatedUser, dateUpdatedUser: $dateUpdatedUser, timeNotifications: ${timeNotificationsUser.toString()}, languageUser: $languageUser)';
  }

  @override
  bool operator ==(covariant DataUser other) {
    if (identical(this, other)) return true;

    return other.idUser == idUser &&
        other.idAsociationUser == idAsociationUser &&
        other.userNameUser == userNameUser &&
        other.emailUser == emailUser &&
        other.tokenUser == tokenUser &&
        other.tokenExpUser == tokenExpUser &&
        other.recoverPasswordUser == recoverPasswordUser &&
        other.questionUser == questionUser &&
        other.answerUser == answerUser &&
        other.profileUser == profileUser &&
        other.statusUser == statusUser &&
        other.nameUser == nameUser &&
        other.lastNameUser == lastNameUser &&
        other.avatarUser == avatarUser &&
        other.phoneUser == phoneUser &&
        other.dateDeletedUser == dateDeletedUser &&
        other.dateCreatedUser == dateCreatedUser &&
        other.dateUpdatedUser == dateUpdatedUser &&
        other.timeNotificationsUser == timeNotificationsUser &&
        other.languageUser == languageUser;
  }

  @override
  int get hashCode {
    return idUser.hashCode ^
        idAsociationUser.hashCode ^
        userNameUser.hashCode ^
        emailUser.hashCode ^
        tokenUser.hashCode ^
        tokenExpUser.hashCode ^
        recoverPasswordUser.hashCode ^
        questionUser.hashCode ^
        answerUser.hashCode ^
        profileUser.hashCode ^
        statusUser.hashCode ^
        nameUser.hashCode ^
        lastNameUser.hashCode ^
        avatarUser.hashCode ^
        phoneUser.hashCode ^
        dateDeletedUser.hashCode ^
        dateCreatedUser.hashCode ^
        dateUpdatedUser.hashCode ^
        timeNotificationsUser.hashCode ^
        languageUser.hashCode;
  }
}

class DataAsoc {
  final int idAsociation;
  final String longNameAsociation;
  final String shortNameAsociation;
  final String logoAsociation;
  final String emailAsociation;
  final String nameContactAsociation;
  final String phoneAsociation;
  final String dateDeletedAsociation;
  final String dateCreatedAsociation;
  final String dateUpdatedAsociation;
  DataAsoc({
    required this.idAsociation,
    required this.longNameAsociation,
    required this.shortNameAsociation,
    required this.logoAsociation,
    required this.emailAsociation,
    required this.nameContactAsociation,
    required this.phoneAsociation,
    required this.dateDeletedAsociation,
    required this.dateCreatedAsociation,
    required this.dateUpdatedAsociation,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id_asociation': idAsociation,
      'long_name_asociation': longNameAsociation,
      'short_name_asociation': shortNameAsociation,
      'logo_asociation': logoAsociation,
      'email_asociation': emailAsociation,
      'name_contact_asociation': nameContactAsociation,
      'phone_asociation': phoneAsociation,
      'date_deleted_asociation': dateDeletedAsociation,
      'date_created_asociation': dateCreatedAsociation,
      'date_updated_asociation': dateUpdatedAsociation,
    };
  }

  factory DataAsoc.fromJson(Map<String, dynamic> json) {
    return DataAsoc(
      idAsociation: json["id_asociation"] is num ? json["id_asociation"] : int.parse(json["id_asociation"]),
      longNameAsociation: json['long_name_asociation'] as String,
      shortNameAsociation: json['short_name_asociation'] as String,
      logoAsociation: json['logo_asociation'] as String,
      emailAsociation: json['email_asociation'] as String,
      nameContactAsociation: json['name_contact_asociation'] as String,
      phoneAsociation: json['phone_asociation'] as String,
      dateDeletedAsociation: json['date_deleted_asociation'] as String,
      dateCreatedAsociation: json['date_created_asociation'] as String,
      dateUpdatedAsociation: json['date_updated_asociation'] as String,
    );
  }

  DataAsoc copyWith({
    int? idAsociation,
    String? longNameAsociation,
    String? shortNameAsociation,
    String? logoAsociation,
    String? emailAsociation,
    String? nameContactAsociation,
    String? phoneAsociation,
    String? dateDeletedAsociation,
    String? dateCreatedAsociation,
    String? dateUpdatedAsociation,
  }) {
    return DataAsoc(
      idAsociation: idAsociation ?? this.idAsociation,
      longNameAsociation: longNameAsociation ?? this.longNameAsociation,
      shortNameAsociation: shortNameAsociation ?? this.shortNameAsociation,
      logoAsociation: logoAsociation ?? this.logoAsociation,
      emailAsociation: emailAsociation ?? this.emailAsociation,
      nameContactAsociation: nameContactAsociation ?? this.nameContactAsociation,
      phoneAsociation: phoneAsociation ?? this.phoneAsociation,
      dateDeletedAsociation: dateDeletedAsociation ?? this.dateDeletedAsociation,
      dateCreatedAsociation: dateCreatedAsociation ?? this.dateCreatedAsociation,
      dateUpdatedAsociation: dateUpdatedAsociation ?? this.dateUpdatedAsociation,
    );
  }

  @override
  String toString() {
    return 'DataAsoc(id_asociation: $idAsociation, longNameAsociation: $longNameAsociation, shortNameAsociation: $shortNameAsociation, logoAsociation: $logoAsociation, emailAsociation: $emailAsociation, nameContactAsociation: $nameContactAsociation, phoneAsociation: $phoneAsociation, dateDeletedAsociation: $dateDeletedAsociation, dateCreatedAsociation: $dateCreatedAsociation, dateUpdatedAsociation: $dateUpdatedAsociation)';
  }

  @override
  bool operator ==(covariant DataAsoc other) {
    if (identical(this, other)) return true;

    return other.idAsociation == idAsociation &&
        other.longNameAsociation == longNameAsociation &&
        other.shortNameAsociation == shortNameAsociation &&
        other.logoAsociation == logoAsociation &&
        other.emailAsociation == emailAsociation &&
        other.nameContactAsociation == nameContactAsociation &&
        other.phoneAsociation == phoneAsociation &&
        other.dateDeletedAsociation == dateDeletedAsociation &&
        other.dateCreatedAsociation == dateCreatedAsociation &&
        other.dateUpdatedAsociation == dateUpdatedAsociation;
  }

  @override
  int get hashCode {
    return idAsociation.hashCode ^
        longNameAsociation.hashCode ^
        shortNameAsociation.hashCode ^
        logoAsociation.hashCode ^
        emailAsociation.hashCode ^
        nameContactAsociation.hashCode ^
        phoneAsociation.hashCode ^
        dateDeletedAsociation.hashCode ^
        dateCreatedAsociation.hashCode ^
        dateUpdatedAsociation.hashCode;
  }
}
