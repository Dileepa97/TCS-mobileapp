import 'package:timecapturesystem/models/Role.dart';

class AuthResponse {
  String token;
  String type;
  String id;
  String username;
  String email;
  String message;
  List<ERole> roles;

  AuthResponse(this.token, this.type, this.id, this.username, this.email,
      this.message, this.roles);

  factory AuthResponse.fromJson(dynamic json) {
    return AuthResponse(
        json['token'] as String,
        json['type'] as String,
        json['id'] as String,
        json['username'] as String,
        json['email'] as String,
        json['message'] as String,
        json['roles'] as List<ERole>);
  }

  @override
  String toString() {
    return 'AuthResponse{token: $token, type: $type, id: $id, username: $username, email: $email, message: $message, roles: $roles}';
  }
}
