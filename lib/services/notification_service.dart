import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:timecapturesystem/services/utils.dart';

String contentTypeHeader = 'application/json';
var apiEndpoint = DotEnv().env['API_URL'].toString();

var notificationAPI = apiEndpoint + 'titles/';

class NotificationService {
  static fetchMyNotifications() async {
    var authHeader = await generateAuthHeader();
    var res = await http.get(notificationAPI, headers: {
      HttpHeaders.authorizationHeader: authHeader,
      HttpHeaders.contentTypeHeader: contentTypeHeader
    });
    return res.statusCode;
  }
}
