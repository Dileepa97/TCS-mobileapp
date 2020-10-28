import 'package:http/http.dart' as http;

class AuthService {
  static const API = 'http://localhost:8080/api/auth/';

  Future<String> login(String username, String password) async {
    var res = await http.post(API + "login",
        body: {"username": username, "password": password});
    if (res.statusCode == 200) return res.body;
    return null;
  }

// Future<int> register(String username, String password) async {
//   var res = await http.post('$API/register',
//       body: {"username": username, "password": password});
//   return res.statusCode;
// }
}
