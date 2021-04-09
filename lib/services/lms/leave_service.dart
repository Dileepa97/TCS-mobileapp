import 'dart:convert';
import 'dart:io';
import 'package:timecapturesystem/services/other/storage_service.dart';
import 'package:timecapturesystem/services/other/utils.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:timecapturesystem/models/lms/leave.dart';
import 'package:http_parser/http_parser.dart';
import 'package:timecapturesystem/models/lms/not_available_users.dart';
import '../other/utils.dart';

var apiEndpoint = DotEnv().env['API_URL'].toString();
String endPointName = 'leaves';
// ignore: non_constant_identifier_names
var API = apiEndpoint + endPointName;
var apiAuth = apiEndpoint.toString().split('/').elementAt(2);

String contentTypeHeader = 'application/json';

class LeaveService {
  ///Create new leave - user
  Future<dynamic> newLeave(
    String leaveTitle,
    String leaveType,
    String leaveDescription,
    String leaveStartDate,
    String leaveEndDate,
    String startDayMethod,
    String endDayMethod,
  ) async {
    try {
      var authHeader = await generateAuthHeader();

      var body = jsonEncode({
        "title": leaveTitle,
        "type": leaveType,
        "description": leaveDescription,
        "startDate": leaveStartDate,
        "endDate": leaveEndDate,
        "startDayMethod": startDayMethod,
        "endDayMethod": endDayMethod,
      });

      var res = await http.post(API, body: body, headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (res.statusCode == 201) {
        return 1;
      } else {
        return -1;
      }
    } catch (e) {
      return -1;
    }
  }

  ///create new leave with attachement - user
  Future<dynamic> newLeaveWithAttachment(
    File file,
    String leaveTitle,
    String leaveType,
    String leaveDescription,
    String leaveStartDate,
    String leaveEndDate,
    String startDayMethod,
    String endDayMethod,
  ) async {
    try {
      var authHeader = await generateAuthHeader();
      Dio dio = Dio();

      String fileType = file.path.split('.').last;
      var id = await TokenStorageService.idOrEmpty;

      String fileName = 'leave' +
          id +
          '@' +
          DateTime.now().toIso8601String().replaceAll(RegExp("[-:.]*"), '') +
          '.' +
          fileType;

      var body = jsonEncode({
        "title": leaveTitle,
        "type": leaveType,
        "description": leaveDescription,
        "startDate": leaveStartDate,
        "endDate": leaveEndDate,
        "startDayMethod": startDayMethod,
        "endDayMethod": endDayMethod,
      });

      FormData formData = FormData.fromMap({
        "leave": MultipartFile.fromString(body,
            contentType: MediaType('application', 'json')),
        "file": await MultipartFile.fromFile(file.path, filename: fileName)
      });

      Response res = await dio.post(API + '/with-upload',
          data: formData,
          options: Options(
            headers: {HttpHeaders.authorizationHeader: authHeader},
          ), onSendProgress: (int sent, int total) {
        print("$sent $total");
      });

      if (res.statusCode == 201) {
        return 1;
      } else {
        return -1;
      }
    } catch (e) {
      return -1;
    }
  }

  ///Get leave by id - anyone
  Future<dynamic> getLeaveById(String id) async {
    try {
      var authHeader = await generateAuthHeader();

      var res = await http.get(API + '/$id', headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);

        Leave _leave = Leave.fromJson(resBody);

        return _leave;
      } else if (res.statusCode == 204) {
        return res.statusCode;
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }

  //Get all leave by month - admin
  Future<dynamic> getLeavesByMonth(dynamic context, int year, int month) async {
    try {
      var params = {
        'year': '$year',
        'month': '$month',
      };

      var uri = Uri.http(apiAuth, 'api/$endPointName/by-month', params);

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
      } else if (res.statusCode == 204) {
        return res.statusCode;
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }

  //Get user leaves by year - admin
  Future<dynamic> getLeavesByUserAndYear(
      dynamic context, String userId, int year) async {
    try {
      var params = {
        'year': '$year',
      };

      var uri = Uri.http(apiAuth, 'api/$endPointName/user/$userId', params);

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
      } else if (res.statusCode == 204) {
        return res.statusCode;
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }

  ///Get logged user leaves by year -  logged user
  Future<dynamic> getLoggedUserLeaves(dynamic context, int year) async {
    try {
      var authHeader = await generateAuthHeader();

      var res = await http.get(API + '/logged-user-by-year/$year', headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);

        List<Leave> _leaveList =
            (resBody as List).map((i) => Leave.fromJson(i)).toList();

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

  ///Get leave by status -  admin
  Future<dynamic> getLeavesByStatusAndYear(
      dynamic context, String status, int year) async {
    try {
      var params = {
        'year': '$year',
      };

      var uri = Uri.http(apiAuth, 'api/$endPointName/status/$status', params);

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
      } else if (res.statusCode == 204) {
        return res.statusCode;
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }

  /// Check requested dates are existing -  user
  Future<dynamic> leaveDateExist(
      String leaveStartDate, String leaveEndDate) async {
    try {
      var authHeader = await generateAuthHeader();

      var body =
          jsonEncode({"startDate": leaveStartDate, "endDate": leaveEndDate});

      http.Response res =
          await http.post(API + '/date-available', body: body, headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (res.statusCode == 204) {
        return res.statusCode;
      } else if (res.statusCode == 200) {
        return res.body.characters.getRange(12).skipLast(2);
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }

  ///Check requested day count -user
  Future<dynamic> checkLeaveDayCounts(
    String leaveStartDate,
    String startDayMethod,
    String leaveEndDate,
    String endDayMethod,
  ) async {
    try {
      var authHeader = await generateAuthHeader();

      var body = jsonEncode({
        "startDate": leaveStartDate,
        "startDayMethod": startDayMethod,
        "endDate": leaveEndDate,
        "endDayMethod": endDayMethod,
      });

      http.Response res =
          await http.post(API + '/day-count-check', body: body, headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (res.statusCode == 200) {
        return res.body;
      } else
        return -1;
    } catch (e) {
      return -1;
    }
  }

  ///Get unavailable users in current date -  admin
  Future<dynamic> getUnavailableUsersToday(
      dynamic context, int year, int month, int day) async {
    try {
      var authHeader = await generateAuthHeader();

      var params = {'year': '$year', 'month': '$month', 'day': '$day'};

      var uri = Uri.http(
          apiAuth, 'api/$endPointName/user-not-available/date', params);

      var res = await http.get(uri, headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);

        NotAvailableUsers _userList = NotAvailableUsers.fromJson(resBody);

        return _userList;
      } else if (res.statusCode == 204) {
        return res.statusCode;
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }

  ///Get team unavailable users in current date -  team leader
  Future<dynamic> getTeamUnavailableUsersToday(
      dynamic context, int year, int month, int day, String teamId) async {
    try {
      var authHeader = await generateAuthHeader();

      var params = {
        'year': '$year',
        'month': '$month',
        'day': '$day',
        'teamId': '$teamId'
      };

      var uri = Uri.http(
          apiAuth, 'api/$endPointName/team-user-not-available/date', params);

      var res = await http.get(uri, headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);

        NotAvailableUsers _userList = NotAvailableUsers.fromJson(resBody);

        return _userList;
      } else if (res.statusCode == 204) {
        return res.statusCode;
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }

  ///Get unavailable users in ahead week -  admin
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
      } else if (res.statusCode == 204) {
        return res.statusCode;
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }

  ///Get team unavailable users in ahead week -  team leader
  Future<dynamic> getTeamUnavailableUsersWeek(
      dynamic context, String teamId) async {
    try {
      var authHeader = await generateAuthHeader();

      var params = {'teamId': '$teamId'};

      var uri = Uri.http(apiAuth,
          'api/$endPointName/team-users-not-available-week-ahead', params);

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
      } else if (res.statusCode == 204) {
        return res.statusCode;
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }

  ///accept or reject leave  - admin
  Future<dynamic> acceptOrReject(
      String leaveId, String status, String reason) async {
    try {
      var authHeader = await generateAuthHeader();

      var params = {
        'leaveId': '$leaveId',
        'status': '$status',
        'reason': '$reason'
      };

      var uri = Uri.http(apiAuth, '/api/$endPointName/change-status', params);

      http.Response response = await http.patch(uri, headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (response.statusCode == 200) {
        return (response.statusCode);
      } else {
        return -1;
      }
    } catch (e) {
      return -1;
    }
  }

  ///cancel leave  - user
  Future<dynamic> cancelLeave(String leaveId) async {
    try {
      var authHeader = await generateAuthHeader();

      http.Response response =
          await http.patch(API + '/cancel-leave/$leaveId', headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (response.statusCode == 200) {
        return (response.statusCode);
      } else {
        return -1;
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
        'leaveId': '$id',
        'takenDays': '$days',
      };

      var uri =
          Uri.http(apiAuth, '/api/$endPointName/accept-leave-cancel', params);

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
