import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timecapturesystem/services/other/utils.dart';
import 'package:http/http.dart' as http;

var apiEndpoint = DotEnv().env['API_URL'].toString();
var API = apiEndpoint + 'available-product';
var apiAuth = DotEnv().env['API_Auth'].toString();
String contentTypeHeader = 'application/json';

class ProductDetailAvailabilityService {
  ///check product name exist or not
  static Future<dynamic> checkProductName(String productName) async {
    try {
      var authHeader = await generateAuthHeader();

      var res = await http.get(API + '/productName/$productName', headers: {
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
