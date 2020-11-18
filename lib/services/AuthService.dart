import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:timecapturesystem/components/dialog_box.dart';
import 'package:timecapturesystem/models/Auth/authRes.dart';
import 'package:timecapturesystem/services/utils.dart';

import 'StorageService.dart';
import 'UserService.dart';

import 'package:timecapturesystem/main.dart' as app;

final storage = FlutterSecureStorage();
Map<String, String> headers = {'Content-Type': 'application/json'};
const API = 'http://192.168.8.100:8080/api/auth/';

class AuthService {
  final UserService userService = UserService();

  static Future<int> login(String username, String password) async {
    var body = jsonEncode({
      "username": username,
      "password": password,
    });

    var res = await http.post(API + "login", body: body, headers: headers);

    if (res.statusCode == 200) {
      AuthResponse authResponse = AuthResponse.fromJson(jsonDecode(res.body));
      authResponse.tokenExpirationDate =
          new DateTime.now().add(new Duration(days: 1));

      print(authResponse);
      //TODO:print

      await storage.write(key: "auth", value: authResponse.toJsonString());
      await storage.write(key: "jwt", value: authResponse.token);

      return 1;
    } else {
      return res.statusCode;
    }
  }

  static Future<bool> register(
      dynamic context,
      String username,
      String fullName,
      String telephoneNumber,
      String email,
      String password) async {
    var jsonBody = jsonEncode({
      "username": username,
      "fullName": fullName,
      "telephoneNumber": telephoneNumber,
      "email": email,
      "password": password,
    });
    http.Response res;
    try {
      res = await http.post(API + 'register', body: jsonBody, headers: headers);

      if (res.statusCode == 200) {
        return true;
      } else if (res.statusCode == 400) {
        displayDialog(
            context, "Error", "Bad request : check values you entered again");
      } else {
        displayDialog(
            context, "Error", "An error occurred while registering user");
      }
    } catch (e) {
      displayDialog(context, "Error", e.toString());
    }
    return false;
  }

  static Future<void> logout() async {
    var authHeader = await generateAuthHeader();
    var res = await http.get(API + "logout",
        headers: {HttpHeaders.authorizationHeader: authHeader});
    await TokenStorageService.clearStorage();
    app.main();
  }
}
