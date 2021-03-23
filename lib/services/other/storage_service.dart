import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:timecapturesystem/models/Auth/auth_response.dart';
import 'package:timecapturesystem/models/user/user.dart';

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

  //use this to get stored data of user
  static Future<User> get userDataOrEmpty async {
    var userData = await storage.read(key: "user");
    if (userData == null) return null;
    return User.fromJson(jsonDecode(userData));
  }

  static Future<String> get idOrEmpty async {
    var auth = await authDataOrEmpty;
    return auth.id;
  }

  static Future<void> clearStorage() async {
    storage.deleteAll();
  }
}
