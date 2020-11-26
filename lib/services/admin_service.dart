import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:timecapturesystem/services/utils.dart';

const API = 'http://localhost:8080/api/auth/';
const userAPI = 'http://localhost:8080/api/users/';
String contentTypeHeader = 'application/json';

class AdminService {
  //handle verification
  //if verified -> un-verify
  //if unverified -> verify
  Future<dynamic> handleUserVerification(userId, isVerified) async {
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

  Future<bool> handleRoleAssignmentRequest(username, endpoint) async {
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
  Future<dynamic> handleAdminRoleAssignment(username, isAdmin) async {
    String endpoint = isAdmin ? 'downgrade-admin/' : 'to-admin/';
    return handleRoleAssignmentRequest(username, endpoint);
  }

  Future<dynamic> handleTeamLeadRoleAssignment(username, isAdmin) async {
    String endpoint = isAdmin ? 'downgrade-teamlead/' : 'to-teamlead/';
    return handleRoleAssignmentRequest(username, endpoint);
  }

  //delete the user
  Future<dynamic> deleteUser(userId) async {
    var authHeader = await generateAuthHeader();
    http.Response res = await http.delete(
      userAPI + userId,
      headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      },
    );
  }
}
