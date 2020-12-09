import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:timecapturesystem/components/dialog_boxes.dart';
import 'package:timecapturesystem/main.dart' as app;
import 'package:timecapturesystem/models/Auth/auth_response.dart';
import 'package:timecapturesystem/models/auth/title.dart';
import 'package:timecapturesystem/services/utils.dart';

import 'storage_service.dart';

var apiEndpoint = DotEnv().env['API_URL'].toString();
// var apiEndpoint =  DotEnv().env['API_URL'];

var authAPI = apiEndpoint + 'auth/';
var titleAPI = apiEndpoint + 'titles/';

String contentTypeHeader = 'application/json';

final storage = FlutterSecureStorage();

// const API = 'http://192.168.8.100:8080/api/auth/';

class AuthService {
  static Future<int> login(String username, String password) async {
    var body = jsonEncode({
      "username": username,
      "password": password,
    });

    var res = await http.post(authAPI + "login",
        body: body,
        headers: {HttpHeaders.contentTypeHeader: contentTypeHeader});

    if (res.statusCode == 200) {
      AuthResponse authResponse = AuthResponse.fromJson(jsonDecode(res.body));
      authResponse.tokenExpirationDate =
          DateTime.now().add(new Duration(days: 1));

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
      String password,
      String gender,
      String title,
      bool probationary) async {
    print(gender);
    var jsonBody = jsonEncode({
      "username": username,
      "fullName": fullName,
      "telephoneNumber": telephoneNumber,
      "email": email,
      "password": password,
      "gender": gender,
      "probationary": probationary,
      "title": (title == 'None' || title == '') ? null : title
    });
    http.Response res;
    try {
      res = await http.post(authAPI + 'register',
          body: jsonBody,
          headers: {HttpHeaders.contentTypeHeader: contentTypeHeader});

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
    // var authHeader = await generateAuthHeader();
    // await http.get(authAPI + "logout",
    //     headers: {HttpHeaders.authorizationHeader: authHeader});
    await TokenStorageService.clearStorage();
  }

  // static Future<void> logoutWithContext(context) async {
  //   var authHeader = await generateAuthHeader();
  //   await http.get(API + "logout",
  //       headers: {HttpHeaders.authorizationHeader: authHeader});
  //   await TokenStorageService.clearStorage();
  //   app.main();
  // }

  static forgotPassword(String email) async {
    var jsonBody = jsonEncode({
      "email": email,
    });
    var res = await http.post(authAPI + "password-reset-req-mobile",
        body: jsonBody,
        headers: {HttpHeaders.contentTypeHeader: contentTypeHeader});

    return res.statusCode;
  }

  static forgotPasswordChange(String password, String code) async {
    var jsonBody = jsonEncode({
      "newPassword": password,
      "code": code,
    });
    try {
      var res = await http.post(authAPI + "reset-password",
          body: jsonBody,
          headers: {HttpHeaders.contentTypeHeader: contentTypeHeader});
      if (res.statusCode == 200) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  static changePassword(oldPassword, newPassword) async {
    var id = await TokenStorageService.idOrEmpty;
    var jsonBody = jsonEncode({
      "id": id,
      "newPassword": newPassword,
      "oldPassword": oldPassword,
    });

    try {
      var res = await http.post(authAPI + "change-password",
          body: jsonBody,
          headers: {HttpHeaders.contentTypeHeader: contentTypeHeader});
      if (res.statusCode == 200) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  static Future<List<String>> getTitles() async {
    var res = await http.get(titleAPI,
        headers: {HttpHeaders.contentTypeHeader: contentTypeHeader});
    List<String> titles = ['None'];
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      for (Map i in data) {
        titles.add(Title.fromJson(i).name);
      }
    }
    return titles;
  }

  static Future<dynamic> addTitle(String title) async {
    var authHeader = await generateAuthHeader();
    var body = jsonEncode({
      "name": title,
    });
    http.Response res = await http.post(
      titleAPI,
      body: body,
      headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      },
    );
    return res.statusCode;
  }

  static Future<dynamic> deleteTitle(deletingTitle) async {
    var authHeader = await generateAuthHeader();
    http.Response res = await http.delete(
      titleAPI + 'deleteByName/' + deletingTitle,
      headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      },
    );
    return res.statusCode;
  }
}
