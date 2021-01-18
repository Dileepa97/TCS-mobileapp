import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:timecapturesystem/models/Auth/auth_response.dart';

final storage = FlutterSecureStorage();

class TokenStorageService {
  static Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "jwt");
    if (jwt == null) return null;
    return jwt;
  }

  // static Future<dynamic> get expirationDateTime async {
  //   var eDate = await storage.read(key: "expiration");
  //   if (eDate == null) return null;
  //   return DateTime.parse(eDate);
  // }

  static Future<AuthResponse> get authDataOrEmpty async {
    var authData = await storage.read(key: "auth");
    if (authData == null) return null;
    return AuthResponse.fromJson(jsonDecode(authData));
  }

  static Future<String> get idOrEmpty async {
    var auth = await authDataOrEmpty;
    return auth.id;
  }

  static Future<void> clearStorage() async {
    storage.deleteAll();
  }
}
