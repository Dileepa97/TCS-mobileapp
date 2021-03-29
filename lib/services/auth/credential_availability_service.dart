import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

var apiEndpoint = DotEnv().env['API_URL'].toString();

var api = apiEndpoint + 'available/';

String contentTypeHeader = 'application/json';

class CredentialAvailabilityService {
  static Future<bool> checkUsernameAvailability(String username) async {
    var res = await http.get(api + "username/" + username,
        headers: {HttpHeaders.contentTypeHeader: contentTypeHeader});
    if (res.statusCode == 200) {
      return toBool(res.body);
    }
    return false;
  }

  static Future<bool> checkEmailAvailability(String email) async {
    var res = await http.get(api + "email/" + email,
        headers: {HttpHeaders.contentTypeHeader: contentTypeHeader});
    if (res.statusCode == 200) {
      return toBool(res.body);
    }
    return false;
  }

  static Future<bool> checkTelephoneAvailability(String telephoneNumber) async {
    var res = await http.get(api + "telephone/" + telephoneNumber,
        headers: {HttpHeaders.contentTypeHeader: contentTypeHeader});
    if (res.statusCode == 200) {
      return toBool(res.body);
    }
    return false;
  }

  static bool toBool(value) {
    return value.toLowerCase() == 'true';
  }

//methods to use in views
  static Future<bool> checkUsernameExist(username) async {
    return await CredentialAvailabilityService.checkUsernameAvailability(
        username);
  }

  static Future<bool> checkEmailExist(email) async {
    return await CredentialAvailabilityService.checkEmailAvailability(email);
  }

  static Future<bool> checkTelephoneNumberExist(telephoneNumber) async {
    return await CredentialAvailabilityService.checkTelephoneAvailability(
        telephoneNumber);
  }
}
