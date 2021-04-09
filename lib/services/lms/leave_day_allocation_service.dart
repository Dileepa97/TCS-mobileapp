import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timecapturesystem/models/lms/leave_day_allocation.dart';
import 'package:timecapturesystem/services/other/utils.dart';
import 'package:http/http.dart' as http;

var apiEndpoint = DotEnv().env['API_URL'].toString();
String endPointName = 'leave-day-allocation';
// ignore: non_constant_identifier_names
var API = apiEndpoint + endPointName;
var apiAuth = apiEndpoint.toString().split('/').elementAt(2);

String contentTypeHeader = 'application/json';

class LeaveDayAllocationService {
  ///get all leave allocation details - admin
  Future<dynamic> getAllLeaveAllocations(dynamic context) async {
    try {
      var authHeader = await generateAuthHeader();

      var res = await http.get(API, headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);

        List<LeaveDayAllocation> _leaveList = (resBody as List)
            .map((i) => LeaveDayAllocation.fromJson(i))
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

  ///change all allowed day count - admin
  Future<dynamic> changeAllowedDays(String type, String allowedDays) async {
    try {
      double days = double.tryParse(allowedDays);

      var authHeader = await generateAuthHeader();

      var params = {
        'type': '$type',
        'allowedDays': '$days',
      };

      var uri =
          Uri.http(apiAuth, '/api/$endPointName/change-allowed-days', params);

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

  ///change single allowed day count - admin
  Future<dynamic> changeSingleAllowedDays(
      String id, String type, String allowedDays) async {
    try {
      double days = double.tryParse(allowedDays);

      var authHeader = await generateAuthHeader();

      var params = {
        'id': '$id',
        'type': '$type',
        'allowedDays': '$days',
      };

      var uri =
          Uri.http(apiAuth, '/api/$endPointName/change-user-allowed', params);

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
