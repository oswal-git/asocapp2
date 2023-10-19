// To parse this JSON data, do
//
//     final asociationsResponse = asociationsResponseFromJson(jsonString);

import 'dart:convert';

AsociationsResponse asociationsResponseFromJson(String str) => AsociationsResponse.fromJson(json.decode(str));

String asociationsResponseToJson(AsociationsResponse data) => json.encode(data.toJson());

class AsociationsResponse {
  int status;
  String message;
  AsociationResult result;

  AsociationsResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory AsociationsResponse.fromJson(Map<String, dynamic> json) => AsociationsResponse(
        status: json["status"],
        message: json["message"],
        result: AsociationResult.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result.toJson(),
      };
}

class AsociationResult {
  int numRecords;
  List<Asociation> records;

  AsociationResult({
    required this.numRecords,
    required this.records,
  });

  factory AsociationResult.fromJson(Map<String, dynamic> json) => AsociationResult(
        numRecords: json["num_records"],
        records: List<Asociation>.from(json["records"].map((x) => Asociation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "num_records": numRecords,
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
      };
}

class Asociation {
  static String table = '';

  int idAsociation;
  String longNameAsociation;
  String shortNameAsociation;
  String logoAsociation;
  String emailAsociation;
  String nameContactAsociation;
  String phoneAsociation;

  Asociation({
    required this.idAsociation,
    required this.longNameAsociation,
    required this.shortNameAsociation,
    required this.logoAsociation,
    required this.emailAsociation,
    required this.nameContactAsociation,
    required this.phoneAsociation,
  });

  factory Asociation.fromJson(Map<String, dynamic> json) {
    return Asociation(
      idAsociation: json["id_asociation"] is num ? json["id_asociation"] : int.parse(json["id_asociation"]),
      longNameAsociation: json["long_name_asociation"],
      shortNameAsociation: json["short_name_asociation"],
      logoAsociation: json["logo_asociation"],
      emailAsociation: json["email_asociation"],
      nameContactAsociation: json["name_contact_asociation"],
      phoneAsociation: json["phone_asociation"],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> toJson = {
      "id_asociation": idAsociation,
      "long_name_asociation": longNameAsociation,
      "short_name_asociation": shortNameAsociation,
      "logo_asociation": logoAsociation,
      "email_asociation": emailAsociation,
      "name_contact_asociation": nameContactAsociation,
      "phone_asociation": phoneAsociation,
    };

    return toJson;
  }

  @override
  String toString() {
    return 'Asociation{ idAsociation: ${idAsociation.toString()}, longNameAsociation: $longNameAsociation, shortNameAsociation: $shortNameAsociation, logoAsociation: $logoAsociation, emailAsociation: $emailAsociation, nameContactAsociation: $nameContactAsociation, phoneAsociation: $phoneAsociation';
  }

  factory Asociation.clear() => Asociation(
        idAsociation: 0,
        longNameAsociation: '',
        shortNameAsociation: '',
        logoAsociation: '',
        emailAsociation: '',
        nameContactAsociation: '',
        phoneAsociation: '',
      );
}

class AsociationsList {
  int id;
  String name;

  AsociationsList({
    required this.id,
    required this.name,
  });

  factory AsociationsList.fromJson(Map<String, dynamic> json) {
    return AsociationsList(
      id: json["id_asociation"],
      name: json["short_name_asociation"],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> toJson = {
      "id_asociation": id,
      "short_name_asociation": name,
    };
    return toJson;
  }

  @override
  String toString() {
    return 'Asociation{ id: ${id.toString()},  name: $name';
  }

  factory AsociationsList.clear() => AsociationsList(
        id: 0,
        name: '',
      );
}
