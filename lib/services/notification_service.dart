import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:timecapturesystem/components/dialog_boxes.dart';
import 'package:timecapturesystem/models/notification/notification.dart';
import 'package:timecapturesystem/services/utils.dart';

String contentTypeHeader = 'application/json';
var apiEndpoint = DotEnv().env['API_URL'].toString();

var notificationAPI = apiEndpoint + 'notification/';

class NotificationService {
  static Future<List<Notification>> fetchMyNotifications(context) async {
    try {
      var authHeader = await generateAuthHeader();
      var res = await http.get(notificationAPI, headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);

        List<Notification> _notificationList =
            (resBody as List).map((i) => Notification.fromJson(i)).toList();

        return _notificationList;
      } else if (res.statusCode == 400) {
        displayDialog(context, "Error", "Bad Request");
      } else {
        displayDialog(
            context, "Error", "An error occurred while fetching notifications");
      }
    } catch (e) {
      displayDialog(context, "Error", e.toString());
    }
    return null;
  }

  static seenNotifications(context) async {
    var authHeader = await generateAuthHeader();
    var res = await http.get(notificationAPI + '/read', headers: {
      HttpHeaders.authorizationHeader: authHeader,
      HttpHeaders.contentTypeHeader: contentTypeHeader
    });
  }
  // this.http.get(API + '/read', httpOptions).subscribe(value => {
  // }, error => {
  // console.log(error);
  // });

}
