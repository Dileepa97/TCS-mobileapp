import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:timecapturesystem/models/leave/LeaveResponse.dart';
import 'package:timecapturesystem/models/leave/LeaveStatus.dart';

final storage = FlutterSecureStorage();
Map<String, String> headers = {'Content-Type': 'application/json'};

class LeaveService {
  static const API = 'http://192.168.8.169:8080/leaves/';

  //static const API = 'http://localhost:8080/leaves/';

  Future<int> newLeave(
      String leaveTitle,
      String leaveType,
      String leaveDescription,
      DateTime leaveStartDate,
      DateTime leaveEndDate,
      double leaveDays,
      LeaveStatus leaveStatus,
      String userId) async {
    var body = jsonEncode({
      "leaveTitle": leaveTitle,
      "leaveType": leaveType,
      "leaveDescription": leaveDescription,
      "leaveStartDate": leaveStartDate.toIso8601String(),
      "leaveEndDate": leaveEndDate.toIso8601String(),
      "leaveDays": leaveDays,
      "leaveStatus": EnumToString.convertToString(leaveStatus),
      "userId": userId
    });

    var res = await http.post(API + "new", body: body, headers: headers);

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
        await http.get('http://192.168.8.169:8080/leaves/all');
    if (response.statusCode == 200) {
      String data = response.body;
      // print(data);
      return jsonDecode(data);
    } else {
      return (response.statusCode);
    }
  }
}
