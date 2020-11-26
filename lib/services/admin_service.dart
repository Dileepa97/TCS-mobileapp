import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:timecapturesystem/services/utils.dart';

const API = 'http://localhost:8080/api/auth/';
const userAPI = 'http://localhost:8080/api/users/';
String contentTypeHeader = 'application/json';

class AdminService {
  //Verify User
  Future<dynamic> verifyUser(userId) async {
    var authHeader = await generateAuthHeader();
    var res = http.get(
      API + 'verify/' + userId,
      headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      },
    );
  }

  //unVerify User
  Future<dynamic> unVerifyUser(userId) async {
    var authHeader = await generateAuthHeader();
    var res = http.get(
      API + 'un-verify/' + userId,
      headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      },
    );
  }

  //toAdmin
  Future<dynamic> upliftToAdmin(username) async {
    var authHeader = await generateAuthHeader();
    var res = http.get(
      API + 'to-admin/' + username,
      headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      },
    );
  }

  //toTeamLead
  Future<dynamic> upliftToTeamLead(username) async {
    var authHeader = await generateAuthHeader();
    var res = http.get(
      API + 'to-teamlead/' + username,
      headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      },
    );
  }

  //downgradeFromAdmin
  Future<dynamic> downgradeFromAdmin(username) async {
    var authHeader = await generateAuthHeader();
    var res = http.get(
      API + 'downgrade-admin/' + username,
      headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      },
    );
  }

  //downgradeFromTeamLead
  Future<dynamic> downgradeFromTeamLead(username) async {
    var authHeader = await generateAuthHeader();
    var res = http.get(
      API + 'downgrade-teamlead/' + username,
      headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      },
    );
  }

  //delete the user
  Future<dynamic> deleteUser(userId) async {
    var authHeader = await generateAuthHeader();
    var res = http.delete(
      userAPI + userId,
      headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      },
    );
  }
}
