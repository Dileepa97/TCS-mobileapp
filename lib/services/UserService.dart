import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/services/utils.dart';
import 'StorageService.dart';

const API = 'http://192.168.8.100:8080/api/users/';

class UserService {
  Future<http.Response> fetchLoggedInUser() async {
    var id = await TokenStorageService.idOrEmpty;
    var authHeader = await generateAuthHeader();
    if (authHeader != null) {
      return http.get(
        API + id,
        headers: {HttpHeaders.authorizationHeader: authHeader},
      );
    }
    return null;
  }

  Future<User> getUser() async {
    var res = await fetchLoggedInUser();
    if (res.statusCode == 200) {
      return User.fromJson(jsonDecode(res.body));
    } else {
      return null;
    }
  }
}
