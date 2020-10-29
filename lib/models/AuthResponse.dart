import 'package:timecapturesystem/models/Role.dart';

class AuthResponse {
  String token;
  String type;
  String id;
  String username;
  String email;
  String message;
  List<dynamic> roles;
  bool verified;

  AuthResponse(this.token, this.type, this.id, this.username, this.email,
      this.message, this.roles, this.verified);

  factory AuthResponse.fromJson(dynamic json) {
    var authRes = AuthResponse(
        json['token'] as String,
        json['type'] as String,
        json['id'] as String,
        json['username'] as String,
        json['email'] as String,
        json['message'] as String,
        json['roles'] as List<dynamic>,
        json['verified'] as bool);

    authRes.roles.forEach((element) {
      element = "$element";
    });
    return authRes;
  }

  @override
  String toString() {
    String s =
        'AuthResponse{"token": "$token", "type": "$type", "id": "$id", "username": "$username", "email": "$email", "message": "$message", "roles":$roles, "verified": $verified}';
    return s;
  }
}
