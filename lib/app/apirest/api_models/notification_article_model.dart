import 'dart:convert';

import 'package:flutter/foundation.dart';

NotificationArticleListResponse notificationArticleListResponseFromJson(String source) =>
    NotificationArticleListResponse.fromJson(json.decode(source));

String notificationArticleListResponseToJson(NotificationArticleListResponse data) => json.encode(data.toJson());

class NotificationArticleListResponse {
  final int status;
  final String message;
  final NotificationArticleListResult result;

  NotificationArticleListResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory NotificationArticleListResponse.fromJson(Map<String, dynamic> json) {
    return NotificationArticleListResponse(
      status: json['status'],
      message: json['message'],
      result: json['result'] == null ? NotificationArticleListResult.clear() : NotificationArticleListResult.fromJson(json['result']),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'status': status,
      'message': message,
      'result': result.toJson(),
    };
  }

  NotificationArticleListResponse copyWith({
    int? status,
    String? message,
    NotificationArticleListResult? result,
  }) {
    return NotificationArticleListResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      result: result ?? this.result,
    );
  }

  factory NotificationArticleListResponse.clear() {
    return NotificationArticleListResponse(
      status: 400,
      message: 'error',
      result: NotificationArticleListResult.clear(),
    );
  }

  @override
  String toString() => 'NotificationArticleListResponse(status: $status, message: $message, notificationArticleListResult: $result)';

  @override
  bool operator ==(covariant NotificationArticleListResponse other) {
    if (identical(this, other)) return true;

    return other.status == status && other.message == message && other.result == result;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ result.hashCode;
}

class NotificationArticleListResult {
  final int numRecords;
  final String dateUpdatedUser;
  final List<NotificationArticle> records;

  NotificationArticleListResult({
    required this.numRecords,
    required this.dateUpdatedUser,
    required this.records,
  });

  factory NotificationArticleListResult.fromJson(Map<String, dynamic> json) {
    return NotificationArticleListResult(
      numRecords: json['num_records'],
      dateUpdatedUser: json['date_updated_user'],
      records: json['num_records'] == 0 ? [] : List<NotificationArticle>.from(json["records"].map((x) => NotificationArticle.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'num_records': numRecords,
      'date_updated_user': dateUpdatedUser,
      'records': List<dynamic>.from(records.map((x) => x.toJson())),
    };
  }

  NotificationArticleListResult copyWith({
    int? numRecords,
    String? dateUpdatedUser,
    List<NotificationArticle>? records,
  }) {
    return NotificationArticleListResult(
      numRecords: numRecords ?? this.numRecords,
      dateUpdatedUser: dateUpdatedUser ?? this.dateUpdatedUser,
      records: records ?? this.records,
    );
  }

  factory NotificationArticleListResult.clear() {
    return NotificationArticleListResult(
      numRecords: 0,
      dateUpdatedUser: '',
      records: [],
    );
  }

  @override
  String toString() => 'NotificationArticleListResult(numRecords: $numRecords, dateUpdatedUser: $dateUpdatedUser, records: $records)';

  @override
  bool operator ==(covariant NotificationArticleListResult other) {
    if (identical(this, other)) return true;

    return other.numRecords == numRecords && other.dateUpdatedUser == dateUpdatedUser && listEquals(other.records, records);
  }

  @override
  int get hashCode => numRecords.hashCode ^ dateUpdatedUser.hashCode ^ records.hashCode;
}

class NotificationArticle {
  final int idArticle;
  final int idAsociationArticle;
  final String titleArticle;
  final String abstractArticle;
  final String coverImageArticle;
  final String dateNotificationArticle;
  final String publicationDateArticle;
  final String expirationDateArticle;
  final String longNameAsociation;
  final String shortNameAsociation;

  NotificationArticle({
    required this.idArticle,
    required this.idAsociationArticle,
    required this.titleArticle,
    required this.abstractArticle,
    required this.coverImageArticle,
    required this.dateNotificationArticle,
    required this.publicationDateArticle,
    required this.expirationDateArticle,
    required this.longNameAsociation,
    required this.shortNameAsociation,
  });

  factory NotificationArticle.fromJson(Map<String, dynamic> json) {
    return NotificationArticle(
      idArticle: int.parse(json['id_article']),
      idAsociationArticle: int.parse(json['id_asociation_article']),
      titleArticle: json['title_article'],
      abstractArticle: json['abstract_article'],
      coverImageArticle: json['cover_image_article'],
      dateNotificationArticle: json['date_notification_article'],
      publicationDateArticle: json['publication_date_article'],
      expirationDateArticle: json['expiration_date_article'],
      longNameAsociation: json['long_name_asociation'],
      shortNameAsociation: json['short_name_asociation'],
    );
  }

  NotificationArticle copyWith({
    int? idArticle,
    int? idAsociationArticle,
    String? titleArticle,
    String? abstractArticle,
    String? coverImageArticle,
    String? dateNotificationArticle,
    String? publicationDateArticle,
    String? expirationDateArticle,
    String? longNameAsociation,
    String? shortNameAsociation,
  }) {
    return NotificationArticle(
      idArticle: idArticle ?? this.idArticle,
      idAsociationArticle: idAsociationArticle ?? this.idAsociationArticle,
      titleArticle: titleArticle ?? this.titleArticle,
      abstractArticle: abstractArticle ?? this.abstractArticle,
      coverImageArticle: coverImageArticle ?? this.coverImageArticle,
      dateNotificationArticle: dateNotificationArticle ?? this.dateNotificationArticle,
      publicationDateArticle: publicationDateArticle ?? this.publicationDateArticle,
      expirationDateArticle: expirationDateArticle ?? this.expirationDateArticle,
      longNameAsociation: longNameAsociation ?? this.longNameAsociation,
      shortNameAsociation: shortNameAsociation ?? this.shortNameAsociation,
    );
  }

  factory NotificationArticle.clear() {
    return NotificationArticle(
      idArticle: 0,
      idAsociationArticle: 0,
      titleArticle: '',
      abstractArticle: '',
      coverImageArticle: '',
      dateNotificationArticle: '',
      publicationDateArticle: '',
      expirationDateArticle: '',
      longNameAsociation: '',
      shortNameAsociation: '',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id_article': idArticle,
      'id_asociation_article': idAsociationArticle,
      'title_article': titleArticle,
      'abstrac_article': abstractArticle,
      'cover_image_article': coverImageArticle,
      'date_notification_article': dateNotificationArticle,
      'publication_date_article': publicationDateArticle,
      'expiration_date_article': expirationDateArticle,
      'long_name_asociation': longNameAsociation,
      'short_name_asociation': shortNameAsociation,
    };
  }

  @override
  String toString() {
    return 'NotificationArticle(id_article: ${idArticle.toString()}, idAsociationArticle: ${idAsociationArticle.toString()}, titleArticle: $titleArticle, abstractArticle: $abstractArticle, coverImageArticle: $coverImageArticle, dateNotificationArticle: $dateNotificationArticle, publicationDateArticle: $publicationDateArticle, expirationDateArticle: $expirationDateArticle)';
  }

  @override
  bool operator ==(covariant NotificationArticle other) {
    if (identical(this, other)) return true;

    return other.idArticle == idArticle &&
        other.idAsociationArticle == idAsociationArticle &&
        other.titleArticle == titleArticle &&
        other.abstractArticle == abstractArticle &&
        other.coverImageArticle == coverImageArticle &&
        other.dateNotificationArticle == dateNotificationArticle &&
        other.publicationDateArticle == publicationDateArticle &&
        other.expirationDateArticle == expirationDateArticle &&
        other.longNameAsociation == longNameAsociation &&
        other.shortNameAsociation == shortNameAsociation;
  }

  @override
  int get hashCode {
    return idArticle.hashCode ^
        idAsociationArticle.hashCode ^
        titleArticle.hashCode ^
        abstractArticle.hashCode ^
        coverImageArticle.hashCode ^
        dateNotificationArticle.hashCode ^
        publicationDateArticle.hashCode ^
        expirationDateArticle.hashCode ^
        longNameAsociation.hashCode ^
        shortNameAsociation.hashCode;
  }
}
