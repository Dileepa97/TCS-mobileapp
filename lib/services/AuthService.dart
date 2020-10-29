import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:timecapturesystem/components/dialog_box.dart';
import 'package:timecapturesystem/models/AuthResponse_model.dart';

final storage = FlutterSecureStorage();

class AuthService {
  static const API = 'http://localhost:8080/api/auth/';

  Future<int> login(String username, String password) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var body = jsonEncode({
      "username": username,
      "password": password,
    });

    var res = await http.post(API + "login", body: body, headers: headers);

    if (res.statusCode == 200) {
      AuthResponse authResponse = AuthResponse.fromJson(jsonDecode(res.body));
      storage.write(key: "auth", value: res.body);
      storage.write(key: "jwt", value: authResponse.token);

      return 1;
    } else {
      return res.statusCode;
    }
  }

// Future<int> register(String username, String password) async {
//   var res = await http.post('$API/register',
//       body: {"username": username, "password": password});
//   return res.statusCode;
// }
}
