import 'dart:convert';

BasicResponse basicUserResponseFromJson(String str) => BasicResponse.fromJson(json.decode(str));

String basicUserResponseToJson(BasicResponse data) => json.encode(data.toJson());

class BasicResponse {
  int status;
  String message;

  BasicResponse({
    required this.status,
    required this.message,
  });

  factory BasicResponse.fromJson(Map<String, dynamic> json) => BasicResponse(
        status: json['status'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
      };
}
