import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:timecapturesystem/models/lms/leave_response.dart';

final storage = FlutterSecureStorage();
Map<String, String> headers = {'Content-Type': 'application/json'};

class LeaveService {
  static const API = 'http://192.168.8.169:8080/api/leaves';

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

  Future<List<LeaveResponse>> fetchLeaves() async {
    var response = await http.get(API + "all");
    List<LeaveResponse> parseLeaves1 = parseLeaves(response.body);
    if (response.statusCode == 200) {
      return parseLeaves1;
    } else {
      throw Exception('Unable to fetch leaves from the REST API');
    }
  }

  List<LeaveResponse> parseLeaves(String responseBody) {
    var parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<LeaveResponse>((json) => LeaveResponse.fromJson(json))
        .toList();
  }

  Future getData() async {
    http.Response response =
        await http.get('http://192.168.8.169:8080/api/leaves');
    if (response.statusCode == 200) {
      String data = response.body;
      // print(data);
      return jsonDecode(data);
    } else {
      return (response.statusCode);
    }
  }

  Future acceptOrReject(String leaveId, String status) async {
    var params = {
      'leaveId': '$leaveId',
      'status': '$status',
    };

    var uri = Uri.http(
        '192.168.8.169:8080', '/api/leaves/status/change/admin', params);
    http.Response response = await http.patch(uri);
    if (response.statusCode == 202) {
      //String data = response.body;
      print('$status');
      return (response.statusCode);
      //return jsonDecode(data);
    } else {
      return (response.statusCode);
    }
  }

  Future getLeavesByStatus(String status) async {
    http.Response response =
        await http.get('http://192.168.8.169:8080/api/leaves/status/$status');
    if (response.statusCode == 200) {
      String data = response.body;
      // print(data);
      return jsonDecode(data);
    } else {
      return (response.statusCode);
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
