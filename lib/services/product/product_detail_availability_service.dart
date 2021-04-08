import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timecapturesystem/services/other/utils.dart';
import 'package:http/http.dart' as http;

var apiEndpoint = DotEnv().env['API_URL'].toString();
String endPointName = 'available-product';
// ignore: non_constant_identifier_names
var API = apiEndpoint + endPointName;
var apiAuth = apiEndpoint.toString().split('/').elementAt(2);

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
