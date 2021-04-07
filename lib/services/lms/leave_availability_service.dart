import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:timecapturesystem/components/dialog_boxes.dart';
import 'package:timecapturesystem/models/lms/leave_availability_detail.dart';
import 'package:timecapturesystem/models/lms/leave_option.dart';

import '../other/utils.dart';

var apiEndpoint = DotEnv().env['API_URL'].toString();
var API = apiEndpoint + 'leave-availability-details';
var apiAuth = DotEnv().env['API_Auth'].toString();
String contentTypeHeader = 'application/json';

final storage = FlutterSecureStorage();
Map<String, String> headers = {'Content-Type': 'application/json'};

class LeaveAvailabilityService {
  Future getAvailableData(String userId, String type) async {
    var params = {'type': '$type'};

    var uri = Uri.http('192.168.8.169:8080',
        '/api/leave-availability-details/user/$userId/type', params);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      String data = response.body;
      // print(data);
      return jsonDecode(data);
    } else {
      return (response.statusCode);
    }
  }

  Future getUserLeaveAvailableData(String userId) async {
    var uri = Uri.http(
        '192.168.8.169:8080', '/api/leave-availability-details/user/$userId');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      String data = response.body;
      // print(data);
      return jsonDecode(data);
    } else {
      return (response.statusCode);
    }
  }

  ///Get logged user leave availability details by year -  logged user
  Future<dynamic> getLoggedUserLeaveAvailability(
      dynamic context, int year) async {
    try {
      var params = {
        'year': '$year',
      };

      var uri = Uri.http(apiAuth,
          'api/leave-availability-details/logged-user-by-year', params);

      var authHeader = await generateAuthHeader();

      var res = await http.get(uri, headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);
        var data = LeaveAvailabilityDetail.fromJson(resBody);

        return data.leaveOptionList;
      } else if (res.statusCode == 204) {
        return res.statusCode;
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }

  ///Get user leave availability details by year -  admin
  Future<dynamic> getUserLeaveAvailability(
      dynamic context, String userId, int year) async {
    try {
      var params = {
        'userId': '$userId',
        'year': '$year',
      };

      var uri = Uri.http(
          apiAuth, 'api/leave-availability-details/user-by-year', params);

      var authHeader = await generateAuthHeader();

      var res = await http.get(uri, headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);
        var data = LeaveAvailabilityDetail.fromJson(resBody);

        return data;
      } else if (res.statusCode == 204) {
        return res.statusCode;
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }

  ///Get logged user leave availability details by year -  logged user
  Future<dynamic> getLoggedUserLeaveAvailabilityByType(
      dynamic context, int year, String type) async {
    try {
      var params = {
        'type': '$type',
        'year': '$year',
      };

      var uri = Uri.http(
          apiAuth, 'api/leave-availability-details/logged-user/option', params);

      var authHeader = await generateAuthHeader();

      var res = await http.get(uri, headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);
        var data = LeaveOption.fromJson(resBody);

        return data;
      } else if (res.statusCode == 204) {
        return res.statusCode;
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }
}
