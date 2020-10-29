import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:timecapturesystem/models/AuthResponse_model.dart';

final storage = FlutterSecureStorage();

class TokenStorageService {
  static Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "jwt");
    if (jwt == null) return null;
    return jwt;
  }

  static Future<AuthResponse> get authDataOrEmpty async {
    var authData = await storage.read(key: "auth");
    if (authData == null) return null;
    return AuthResponse.fromJson(jsonDecode(authData));
  }
}
