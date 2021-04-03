import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as str;
import 'package:timecapturesystem/models/lms/leave_cancel_details.dart';
import 'package:timecapturesystem/services/other/utils.dart';
import 'package:http/http.dart' as http;

var apiEndpoint = DotEnv().env['API_URL'].toString();
var API = apiEndpoint + 'leave-cancel';

var apiAuth = DotEnv().env['API_Auth'].toString();

String contentTypeHeader = 'application/json';

final storage = str.FlutterSecureStorage();

class LeaveCancelService {
  ///get all ongoing leave cancellation details - admin
  Future<dynamic> getAllLeaveCancelDetails(dynamic context) async {
    try {
      var authHeader = await generateAuthHeader();
      var res = await http.get(API, headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });
      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);

        List<LeaveCancelDetails> _leaveList = (resBody as List)
            .map((i) => LeaveCancelDetails.fromJson(i))
            .toList();

        return _leaveList;
      } else if (res.statusCode == 204) {
        return res.statusCode;
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }

  ///set taken days for ongoing cancel leave - admin
  Future<dynamic> setTakenDays(String id, String takenDays) async {
    try {
      double days = double.tryParse(takenDays);

      var authHeader = await generateAuthHeader();

      var params = {
        'leaveCancelId': '$id',
        'takenDays': '$days',
      };

      var uri =
          Uri.http(apiAuth, '/api/leave-cancel/accept-leave-cancel', params);

      http.Response response = await http.patch(uri, headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (response.statusCode == 200) {
        return (response.statusCode);
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }
}
