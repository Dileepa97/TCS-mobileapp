import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  String token;
  String type;
  String id;
  String message;
  DateTime tokenExpirationDate;

  AuthResponse(
      this.token, this.type, this.id, this.message, this.tokenExpirationDate);

  factory AuthResponse.fromJson(Map<String, dynamic> data) =>
      _$AuthResponseFromJson(data);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);

  @override
  String toString() {
    return 'AuthResponse{token: $token, type: $type, id: $id, message: $message, tokenExpirationDate: $tokenExpirationDate}';
  }

  String toJsonString() {
    return '{"token": "$token", "type": "$type", "id": "$id", "tokenExpirationDate": "$tokenExpirationDate"}';
  }
}
