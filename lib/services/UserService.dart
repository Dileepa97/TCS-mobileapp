import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:timecapturesystem/models/user/user.dart';
import 'StorageService.dart';

const API = 'http://localhost:8080/api/users/';

Future<http.Response> fetchLoggedInUser() async {
  final TokenStorageService tokenStorageService = TokenStorageService();
  var id = await tokenStorageService.idOrEmpty;
  var token = await tokenStorageService.jwtOrEmpty;
  if (token != null) {
    return http.get(
      API + id,
      headers: {HttpHeaders.authorizationHeader: 'Bearer ' + token},
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
