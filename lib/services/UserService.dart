import 'dart:io';
import 'package:http/http.dart' as http;
import 'StorageService.dart';

const API = 'http://localhost:8080/api/users/';

Future<http.Response> fetchUser() async {
  final TokenStorageService tokenStorageService = TokenStorageService();
  var authData = await tokenStorageService.authDataOrEmpty;
  var id = authData.id;
  var token = await tokenStorageService.jwtOrEmpty;
  if (token != null) {
    return http.get(
      API + id,
      headers: {HttpHeaders.authorizationHeader: 'Bearer ' + token},
    );
  }
  return null;
}
