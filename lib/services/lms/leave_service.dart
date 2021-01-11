import 'dart:convert';
import 'dart:io';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:timecapturesystem/components/dialog_boxes.dart';
import 'package:timecapturesystem/models/lms/leave.dart';
import 'package:timecapturesystem/models/lms/leave_response.dart';
import 'package:timecapturesystem/models/lms/not_available_users.dart';

import '../utils.dart';

var apiEndpoint = DotEnv().env['API_URL'].toString();
var API = apiEndpoint + 'leaves';
var apiAuth = DotEnv().env['API_Auth'].toString();
String contentTypeHeader = 'application/json';

final storage = FlutterSecureStorage();
Map<String, String> headers = {'Content-Type': 'application/json'};

class LeaveService {
  //static const API = 'http://192.168.8.169:8080/api/leaves';

  //static const API = 'http://localhost:8080/api/leaves/';

  Future<int> newLeave(
      String leaveTitle,
      String leaveType,
      String leaveDescription,
      String leaveStartDate,
      String leaveEndDate,
      String startDayMethod,
      String endDayMethod,
      String userId) async {
    var body = jsonEncode({
      "title": leaveTitle,
      "type": leaveType,
      "description": leaveDescription,
      "startDate": leaveStartDate,
      "endDate": leaveEndDate,
      "startDayMethod": startDayMethod,
      "endDayMethod": endDayMethod,
      "userId": userId
    });

    var res = await http.post(API, body: body, headers: headers);
    //print(res.statusCode);

    if (res.statusCode == 201) {
      // LeaveResponse leaveResponse =
      //     LeaveResponse.fromJson(jsonDecode(res.body));
      // storage.write(key: "leave", value: res.body);
      //storage.write(key: "jwt", value: authResponse.token);

      return 1;
    } else {
      return res.statusCode;
    }
  }

  Future<List<Leave>> getAllLeaves(dynamic context) async {
    try {
      var authHeader = await generateAuthHeader();
      var res = await http.get(API, headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });
      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);

        List<Leave> _leaveList =
            (resBody as List).map((i) => Leave.fromJson(i)).toList();

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

  ///Get leave by id
  Future<dynamic> getLeaveById(String id) async {
    try {
      var authHeader = await generateAuthHeader();

      var res = await http.get(API + '/$id', headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);

        Leave _leaveList = Leave.fromJson(resBody);

        return _leaveList;
      } else if (res.statusCode == 400) {
        return res.statusCode;
      } else if (res.statusCode == 204) {
        return res.statusCode;
      } else {
        return 1;
      }
    } catch (e) {
      // displayDialog( "Error", e.toString());
    }
    return null;
  }

  //Get all leave by month - admin
  Future<dynamic> getLeavesByMonth(dynamic context, int year, int month) async {
    try {
      var params = {
        'year': '$year',
        'month': '$month',
      };

      var uri = Uri.http(apiAuth, 'api/leaves/by-month', params);

      var authHeader = await generateAuthHeader();

      var res = await http.get(uri, headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);

        List<Leave> _leaveList =
            (resBody as List).map((i) => Leave.fromJson(i)).toList();

        return _leaveList;
      } else if (res.statusCode == 400) {
        return res.statusCode;
      } else if (res.statusCode == 204) {
        return res.statusCode;
      } else {
        return 1;
      }
    } catch (e) {
      displayDialog(context, "Error", e.toString());
    }
    return null;
  }

  ///Get logged user leaves by year -  logged user
  Future<dynamic> getLoggedUserLeaves(dynamic context, int year) async {
    try {
      var params = {
        'year': '$year',
      };

      var uri = Uri.http(apiAuth, 'api/leaves/logged-user', params);

      var authHeader = await generateAuthHeader();

      var res = await http.get(uri, headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);

        List<Leave> _leaveList =
            (resBody as List).map((i) => Leave.fromJson(i)).toList();

        return _leaveList;
      } else if (res.statusCode == 400) {
        return res.statusCode;
      } else if (res.statusCode == 204) {
        return res.statusCode;
      } else {
        return 1;
      }
    } catch (e) {
      displayDialog(context, "Error", e.toString());
    }
    return null;
  }

  ///Get leave by status(current year) -  admin
  Future<dynamic> getLeavesByStatus(dynamic context, String status) async {
    try {
      var authHeader = await generateAuthHeader();

      var res = await http.get(API + '/status/$status', headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);

        List<Leave> _leaveList =
            (resBody as List).map((i) => Leave.fromJson(i)).toList();

        return _leaveList;
      } else if (res.statusCode == 400) {
        return res.statusCode;
      } else if (res.statusCode == 204) {
        return res.statusCode;
      } else {
        return 1;
      }
    } catch (e) {
      displayDialog(context, "Error", e.toString());
    }
    return null;
  }

  ///Get unavailable users in current date -  admin
  Future<dynamic> getUnavailableUsersToday(
      dynamic context, int year, int month, int day) async {
    try {
      var authHeader = await generateAuthHeader();

      var params = {'year': '$year', 'month': '$month', 'day': '$day'};

      var uri = Uri.http(apiAuth, 'api/leaves/user-not-available/date', params);

      var res = await http.get(uri, headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);

        List<NotAvailableUsers> _userList = (resBody as List)
            .map((i) => NotAvailableUsers.fromJson(i))
            .toList();

        return _userList;
      } else if (res.statusCode == 400) {
        return res.statusCode;
      } else if (res.statusCode == 204) {
        return res.statusCode;
      } else {
        return 1;
      }
    } catch (e) {
      displayDialog(context, "Error", e.toString());
    }
    return null;
  }

  ///Get unavailable users in current week -  admin
  Future<dynamic> getUnavailableUsersWeek(dynamic context) async {
    try {
      var authHeader = await generateAuthHeader();

      var res =
          await http.get(API + '/users-not-available-week-ahead', headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);

        List<NotAvailableUsers> _userList = (resBody as List)
            .map((i) => NotAvailableUsers.fromJson(i))
            .toList();

        return _userList;
      } else if (res.statusCode == 400) {
        return res.statusCode;
      } else if (res.statusCode == 204) {
        return res.statusCode;
      } else {
        return 1;
      }
    } catch (e) {
      displayDialog(context, "Error", e.toString());
    }
    return null;
  }

  Future getData() async {
    var authHeader = await generateAuthHeader();
    http.Response res = await http.get(
      API,
      headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      },
    );
    if (res.statusCode == 200) {
      String data = res.body;
      return jsonDecode(data);
    } else {
      return (res.statusCode);
    }
  }

  Future<dynamic> acceptOrReject(
      String leaveId, String status, String reason) async {
    try {
      var authHeader = await generateAuthHeader();

      var params = {
        'leaveId': '$leaveId',
        'status': '$status',
        'reason': '$reason'
      };

      var uri = Uri.http(apiAuth, '/api/leaves/change-status', params);

      http.Response response = await http.patch(uri, headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (response.statusCode == 200) {
        //String data = response.body;
        //print('$status');
        return (response.statusCode);
        //return jsonDecode(data);
      } else {
        return (response.statusCode);
      }
    } catch (e) {
      //displayDialog(context, "Error", e.toString());
    }
  }

  Future getAUserLeaves(String userId) async {
    http.Response response =
        await http.get('http://192.168.8.169:8080/api/leaves/user/$userId');
    if (response.statusCode == 200) {
      String data = response.body;
      // print(data);
      return jsonDecode(data);
    } else {
      return (response.statusCode);
    }
  }

  Future cancelLeave(String leaveId) async {
    http.Response response = await http
        .patch('http://192.168.8.169:8080/api/leaves/$leaveId/status/cancel');
    if (response.statusCode == 202) {
      //String data = response.body;
      // print(data);
      return (response.statusCode);
    } else {
      return (response.statusCode);
    }
  }
}
