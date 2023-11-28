import 'dart:convert';

QuestionListUserResponse questionListUserResponseFromJson(String str) => QuestionListUserResponse.fromJson(json.decode(str));

String questionListUserResponseToJson(QuestionListUserResponse data) => json.encode(data.toJson());

class QuestionListUserResponse {
  int status;
  String message;
  QuestionListUserResult result;

  QuestionListUserResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory QuestionListUserResponse.fromJson(Map<String, dynamic> json) => QuestionListUserResponse(
        status: json["status"],
        message: json["message"],
        result: QuestionListUserResult.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result.toJson(),
      };
}

class QuestionListUserResult {
  int numRecords;
  List<QuestionListUser> records;

  QuestionListUserResult({
    required this.numRecords,
    required this.records,
  });

  factory QuestionListUserResult.fromJson(Map<String, dynamic> json) => QuestionListUserResult(
        numRecords: json["num_records"],
        records: List<QuestionListUser>.from(json["records"].map((x) => QuestionListUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "num_records": numRecords,
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
      };
}

class QuestionListUser {
  int idUser;
  int asociationIdUser;
  String userNameUser;
  String questionUser;
  DateTime dateUpdatedUser;
  String longNameAsociation;
  String shortNameAsociation;
  String logoAsociation;

  QuestionListUser({
    required this.idUser,
    required this.asociationIdUser,
    required this.userNameUser,
    required this.questionUser,
    required this.dateUpdatedUser,
    required this.longNameAsociation,
    required this.shortNameAsociation,
    required this.logoAsociation,
  });

  factory QuestionListUser.fromJson(Map<String, dynamic> json) => QuestionListUser(
        idUser: int.parse(json["id_user"]),
        asociationIdUser: int.parse(json["id_asociation_user"]),
        userNameUser: json["user_name_user"],
        questionUser: json["question_user"],
        dateUpdatedUser: DateTime.parse(json["date_updated_user"]),
        longNameAsociation: json["long_name_asociation"],
        shortNameAsociation: json["short_name_asociation"],
        logoAsociation: json["logo_asociation"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> toJson = {
      "id_user": idUser,
      "id_asociation_user": asociationIdUser,
      "user_name_user": userNameUser,
      "question_user": questionUser,
      "date_updated_user": dateUpdatedUser.toIso8601String(),
      "long_name_asociation": longNameAsociation,
      "short_name_asociation": shortNameAsociation,
      "logo_asociation": logoAsociation,
    };

    return toJson;
  }

  @override
  String toString() {
    return 'QuestionListUser { idUser: $idUser, asociationIdUser: $asociationIdUser, userNameUser: $userNameUser, questionUser: $questionUser, dateUpdatedUser: $dateUpdatedUser, longNameAsociation: $longNameAsociation, shortNameAsociation: $shortNameAsociation, logoAsociation: $logoAsociation';
  }

  factory QuestionListUser.clear() => QuestionListUser(
        idUser: 0,
        asociationIdUser: 0,
        userNameUser: '',
        questionUser: '',
        dateUpdatedUser: DateTime.now(),
        longNameAsociation: '',
        shortNameAsociation: '',
        logoAsociation: '',
      );
}

class QuestionList {
  String status;
  String question;
  List<Map<String, dynamic>> questions;
  bool showClave;

  QuestionList({
    required this.status,
    required this.question,
    required this.questions,
    required this.showClave,
  });

  factory QuestionList.clear() => QuestionList(
        status: '',
        question: '',
        questions: [],
        showClave: false,
      );
}
