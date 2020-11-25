import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:timecapturesystem/components/dialog_box.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/services/utils.dart';
import 'storage_service.dart';

String contentTypeHeader = 'application/json';

// const API = 'http://192.168.8.100:8080/api/users/';
const API = 'http://localhost:8080/api/users/';

class UserService {
  Future<http.Response> fetchLoggedInUser() async {
    var id = await TokenStorageService.idOrEmpty;
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

  Future<User> getUser() async {
    var res = await fetchLoggedInUser();
    if (res.statusCode == 200) {
      return User.fromJson(jsonDecode(res.body));
    } else {
      return null;
    }
  }

  Future<bool> updateUser(dynamic context, String username, String fullName,
      String email, String telephoneNumber) async {
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

  Future<dynamic> getAllUsers(dynamic context) async {
    try {
      var authHeader = await generateAuthHeader();
      var res = await http.patch(API, headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });
      if (res.statusCode == 200) {
        List<dynamic> _userList = jsonDecode(res.body);
        List<dynamic> userList = [];
        _userList.forEach((element) {
          userList.add(User.fromJson(jsonDecode(element)));
        });
        return userList;
      } else if (res.statusCode == 400) {
        displayDialog(context, "Error", "Bad request");
      } else {
        displayDialog(
            context, "Error", "An error occurred while fetching users");
      }
    } catch (e) {
      displayDialog(context, "Error", e.toString());
    }
    return null;
  }
}
