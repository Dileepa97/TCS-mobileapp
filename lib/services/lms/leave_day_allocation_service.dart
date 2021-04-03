import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart' as str;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timecapturesystem/components/dialog_boxes.dart';
import 'package:timecapturesystem/models/lms/leave_day_allocation.dart';
import 'package:timecapturesystem/services/other/utils.dart';
import 'package:http/http.dart' as http;

var apiEndpoint = DotEnv().env['API_URL'].toString();
var API = apiEndpoint + 'leave-day-allocation';
var apiAuth = DotEnv().env['API_Auth'].toString();
String contentTypeHeader = 'application/json';

final storage = str.FlutterSecureStorage();
Map<String, String> headers = {'Content-Type': 'application/json'};

class LeaveDayAllocationService {
  ///get all leave allocation details - admin
  Future<List<LeaveDayAllocation>> getAllLeaveAllocations(
      dynamic context) async {
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
      } else if (res.statusCode == 400) {
        displayDialog(context, "Error", "Bad Request");
      } else {
        displayDialog(
            context, "Error", "An error occurred while fetching users");
      }
    } catch (e) {
      displayDialog(context, "Error", e.toString());
    }
    return null;
  }

  Future<dynamic> changeAllowedDays(String type, String allowedDays) async {
    try {
      print('done');
      print(allowedDays);
      print(type);
      double days = double.tryParse(allowedDays);
      print(days);
      var authHeader = await generateAuthHeader();

      var params = {
        'type': '$type',
        'allowedDays': '$days',
      };

      var uri = Uri.http(
          apiAuth, '/api/leave-day-allocation/change-allowed-days', params);

      http.Response response = await http.patch(uri, headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (response.statusCode == 200) {
        //String data = response.body;
        //print('$status');
        print(response);
        return (response.statusCode);
        //return jsonDecode(data);
      } else {
        print(response);
        return (response.statusCode);
      }
    } catch (e) {
      print(e);
      //displayDialog(context, "Error", e.toString());
    }
  }
}
