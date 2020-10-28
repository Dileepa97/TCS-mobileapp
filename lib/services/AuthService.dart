import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class AuthService {
  static const API = 'http://localhost:8080/api/auth/';

  Future<String> login(String username, String password) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var body = jsonEncode({
      "username": username,
      "password": password,
    });

    var res = await http.post(API + "login", body: body, headers: headers);

    if (res.statusCode == 200) {
      print(res.body);
      var responseBody = jsonDecode(res.body);
      if (responseBody.token == null) {
        return null;
      }
      storage.write(key: "jwt", value: responseBody.token);
      print(responseBody.token);
      return res.body;
    }
    return null;
  }

// Future<int> register(String username, String password) async {
//   var res = await http.post('$API/register',
//       body: {"username": username, "password": password});
//   return res.statusCode;
// }
}
