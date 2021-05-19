import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:timecapturesystem/models/report/team_member_report.dart';
import 'package:timecapturesystem/services/other/utils.dart';

String contentTypeHeader = 'application/json';
var apiEndpoint = DotEnv().env['API_URL'].toString();

class ReportService {

  static Future<TeamMemberReport> getTeamMemberReport(String teamMemberId) async {

    var authHeader = await generateAuthHeader();

    http.Response response = await http.get(apiEndpoint + "team-member-report/"+teamMemberId,
        headers: {
          HttpHeaders.authorizationHeader: authHeader,
          HttpHeaders.contentTypeHeader: contentTypeHeader
        }).catchError((error) => {print(error.toString())});

    print(response.statusCode);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return new TeamMemberReport.formJson(jsonData);
    } else {
      return null;
    }
  }

}