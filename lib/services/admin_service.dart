import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:timecapturesystem/services/utils.dart';

var apiEndpoint = DotEnv().env['K_IP'].toString();
// var apiEndpoint =  DotEnv().env['API_URL'];

var API = apiEndpoint + 'auth/';
var userAPI = apiEndpoint + 'users/';
String contentTypeHeader = 'application/json';

class AdminService {
  //handle verification
  //if verified -> un-verify
  //if unverified -> verify
  static Future<dynamic> handleUserVerification(userId, isVerified) async {
    String endpoint = isVerified ? 'un-verify/' : 'verify/';
    var authHeader = await generateAuthHeader();
    http.Response res = await http.get(
      API + endpoint + userId,
      headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      },
    );
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> handleRoleAssignmentRequest(username, endpoint) async {
    var authHeader = await generateAuthHeader();
    http.Response res = await http.get(
      API + endpoint + username,
      headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      },
    );
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //handleRole assignment
  static Future<dynamic> handleAdminRoleAssignment(username, isAdmin) async {
    String endpoint = isAdmin ? 'downgrade-admin/' : 'to-admin/';
    return handleRoleAssignmentRequest(username, endpoint);
  }

  static Future<dynamic> handleTeamLeadRoleAssignment(username, isAdmin) async {
    String endpoint = isAdmin ? 'downgrade-teamlead/' : 'to-teamlead/';
    return handleRoleAssignmentRequest(username, endpoint);
  }

  //delete the user
  static Future<bool> deleteUser(userId) async {
    var authHeader = await generateAuthHeader();
    http.Response res = await http.delete(
      userAPI + userId,
      headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      },
    );

    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
