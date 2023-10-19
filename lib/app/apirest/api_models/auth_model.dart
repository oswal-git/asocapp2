import 'dart:convert';

class UserCreated {
  final int status;
  final String message;
  final IdUserCreated result;
  UserCreated({
    required this.status,
    required this.message,
    required this.result,
  });

  UserCreated copyWith({
    int? status,
    String? message,
    IdUserCreated? result,
  }) {
    return UserCreated(
      status: status ?? this.status,
      message: message ?? this.message,
      result: result ?? this.result,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'message': message,
      'result': result.toMap(),
    };
  }

  factory UserCreated.fromMap(Map<String, dynamic> map) {
    return UserCreated(
      status: map['status'].toInt() as int,
      message: map['message'] as String,
      result: IdUserCreated.fromMap(map['result'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserCreated.fromJson(String source) => UserCreated.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserCreated(status: $status, message: $message, result: $result)';

  @override
  bool operator ==(covariant UserCreated other) {
    if (identical(this, other)) return true;

    return other.status == status && other.message == message && other.result == result;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ result.hashCode;
}

class IdUserCreated {
  final int id;
  IdUserCreated({
    required this.id,
  });

  IdUserCreated copyWith({
    int? id,
  }) {
    return IdUserCreated(
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
    };
  }

  factory IdUserCreated.fromMap(Map<String, dynamic> map) {
    return IdUserCreated(
      id: map['id'].toInt() as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory IdUserCreated.fromJson(String source) => IdUserCreated.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'IdUserCreated(id: $id)';

  @override
  bool operator ==(covariant IdUserCreated other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
