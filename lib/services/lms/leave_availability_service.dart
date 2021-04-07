import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:timecapturesystem/models/lms/leave_availability_detail.dart';
import 'package:timecapturesystem/models/lms/leave_option.dart';
import '../other/utils.dart';

var apiEndpoint = DotEnv().env['API_URL'].toString();
String endPointName = 'leave-availability-details';
var API = apiEndpoint + endPointName;
var apiAuth = apiEndpoint.toString().split('/').elementAt(2);

String contentTypeHeader = 'application/json';

class LeaveAvailabilityService {
  ///Get logged user leave availability details by year -  logged user
  Future<dynamic> getLoggedUserLeaveAvailability(
      dynamic context, int year) async {
    try {
      var params = {
        'year': '$year',
      };

      var uri =
          Uri.http(apiAuth, 'api/$endPointName/logged-user-by-year', params);

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

      var uri = Uri.http(apiAuth, 'api/$endPointName/user-by-year', params);

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

  ///Get logged user leave availability details by year and type -  logged user
  Future<dynamic> getLoggedUserLeaveAvailabilityByType(
      dynamic context, int year, String type) async {
    try {
      var params = {
        'type': '$type',
        'year': '$year',
      };

      var uri =
          Uri.http(apiAuth, 'api/$endPointName/logged-user/option', params);

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
