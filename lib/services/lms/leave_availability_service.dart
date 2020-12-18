import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

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
}
