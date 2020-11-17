import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:timecapturesystem/models/Auth/AuthResponse.dart';

final storage = FlutterSecureStorage();

class TokenStorageService {
  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "jwt");
    if (jwt == null) return null;
    return jwt;
  }

  Future<AuthResponse> get authDataOrEmpty async {
    var authData = await storage.read(key: "auth");
    if (authData == null) return null;
    return AuthResponse.fromJson(jsonDecode(authData));
  }

  Future<String> get idOrEmpty async {
    var auth = await authDataOrEmpty;
    return auth.id;
  }
}
