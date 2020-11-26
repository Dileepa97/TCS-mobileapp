import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:timecapturesystem/components/dialog_box.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/models/user/user_history.dart';
import 'package:timecapturesystem/services/utils.dart';
import 'storage_service.dart';

String contentTypeHeader = 'application/json';

// const API = 'http://192.168.8.100:8080/api/users/';
const API = 'http://localhost:8080/api/users/';
const historyAPI = 'http://localhost:8080/api/userHistory/';

class UserService {
  static Future<http.Response> fetchUserById(id) async {
    var authHeader = await generateAuthHeader();
    if (authHeader != null) {
      return http.get(
        API + id,
        headers: {
          HttpHeaders.authorizationHeader: authHeader,
          HttpHeaders.contentTypeHeader: contentTypeHeader
        },
      );
    }
    return null;
  }

  static Future<http.Response> fetchLoggedInUser() async {
    var id = await TokenStorageService.idOrEmpty;
    return fetchUserById(id);
  }

  static Future<User> getLoggedInUser() async {
    var res = await fetchLoggedInUser();
    if (res.statusCode == 200) {
      return User.fromJson(jsonDecode(res.body));
    } else {
      return null;
    }
  }

  static Future<User> getUserById(userId) async {
    var res = await fetchUserById(userId);
    if (res.statusCode == 200) {
      return User.fromJson(jsonDecode(res.body));
    } else {
      return null;
    }
  }

  static Future<bool> updateUser(dynamic context, String username,
      String fullName, String email, String telephoneNumber) async {
    var jsonBody = jsonEncode({
      "username": username,
      "fullName": fullName,
      "telephoneNumber": telephoneNumber,
      "email": email,
    });
    http.Response res;
    try {
      var id = await TokenStorageService.idOrEmpty;
      var authHeader = await generateAuthHeader();
      res = await http.patch(API + id, body: jsonBody, headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });
      if (res.statusCode == 200) {
        return true;
      } else if (res.statusCode == 400) {
        displayDialog(
            context, "Error", "Bad request : check values you entered again");
      } else {
        displayDialog(
            context, "Error", "An error occurred while updating user");
      }
    } catch (e) {
      displayDialog(context, "Error", e.toString());
    }
    return false;
  }

  static Future<List<User>> getAllUsers(dynamic context) async {
    try {
      var authHeader = await generateAuthHeader();
      var res = await http.get(API, headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });
      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);

        List<User> _userList =
            (resBody as List).map((i) => User.fromJson(i)).toList();

        return _userList;
      } else if (res.statusCode == 400) {
        displayDialog(context, "Error", "Bad Request");
      } else {
        displayDialog(
            context, "Error", "An error occurred while fetching users");
      }
    } catch (e) {
      displayDialog(context, "Error", e.toString());
    }
    return null;
  }

  static Future<UserHistory> fetchUserHistoryById(id) async {
    var authHeader = await generateAuthHeader();
    if (authHeader != null) {
      http.Response res = await http.get(
        historyAPI + id,
        headers: {
          HttpHeaders.authorizationHeader: authHeader,
          HttpHeaders.contentTypeHeader: contentTypeHeader
        },
      );
      if (res.statusCode == 200) {
        return UserHistory.fromJson(jsonDecode(res.body));
      }
    }
    return null;
  }
}
