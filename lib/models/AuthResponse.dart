class AuthResponse {
  String token;
  String type;
  String id;
  String message;

  AuthResponse(this.token, this.type, this.id, this.message);

  factory AuthResponse.fromJson(dynamic json) {
    var authRes = AuthResponse(
      json['token'] as String,
      json['type'] as String,
      json['id'] as String,
      json['message'] as String,
    );

    return authRes;
  }

  @override
  String toString() {
    return 'AuthResponse{token: $token, type: $type, id: $id, message: $message}';
  }
}
