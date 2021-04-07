import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timecapturesystem/services/other/utils.dart';
import 'package:http/http.dart' as http;

var apiEndpoint = DotEnv().env['API_URL'].toString();
var API = apiEndpoint + 'available-customer';
var apiAuth = DotEnv().env['API_Auth'].toString();
String contentTypeHeader = 'application/json';

class CustomerDetailAvailabilityService {
  ///check org id exist or not
  static Future<dynamic> checkOrgId(String orgId) async {
    try {
      var authHeader = await generateAuthHeader();

      var res = await http.get(API + '/orgID/$orgId', headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);
        return resBody;
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }

  ///check org name exist or not
  static Future<dynamic> checkOrgName(String orgName) async {
    try {
      var authHeader = await generateAuthHeader();

      var res = await http.get(API + '/orgName/$orgName', headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);
        return resBody;
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }
}
