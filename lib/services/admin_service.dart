import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:timecapturesystem/services/utils.dart';

const API = 'http://localhost:8080/api/auth/';
String contentTypeHeader = 'application/json';

class AdminService {
  //Verify User
  Future<dynamic> verifyUser(userId) async {
    var authHeader = await generateAuthHeader();
    http.get(
      API,
      headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      },
    );
  }

  //unVerify User
  Future<dynamic> unVerifyUser(userId) async {
    var authHeader = await generateAuthHeader();
    http.get(
      API,
      headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      },
    );
  }

  //toAdmin
  Future<dynamic> upliftToAdmin(userId) async {
    var authHeader = await generateAuthHeader();
    http.get(
      API,
      headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      },
    );
  }

  //toTeamLead
  Future<dynamic> upliftToTeamLead(userId) async {
    var authHeader = await generateAuthHeader();
    http.get(
      API,
      headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      },
    );
  }

  //downgradeFromAdmin
  Future<dynamic> downgradeFromAdmin(userId) async {
    var authHeader = await generateAuthHeader();
    http.get(
      API,
      headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      },
    );
  }

  //downgradeFromTeamLead
  Future<dynamic> downgradeFromTeamLead(userId) async {
    var authHeader = await generateAuthHeader();
    http.get(
      API,
      headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      },
    );
  }

  //delete the user
  Future<dynamic> deleteUser(userId) async {
    var authHeader = await generateAuthHeader();
    http.get(
      API,
      headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      },
    );
  }
}
