
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timecapturesystem/models/task/team_member_task.dart';
import 'package:timecapturesystem/services/other/utils.dart';

String contentTypeHeader = 'application/json';
var apiEndpoint = DotEnv().env['API_URL'].toString();

class TeamTasksService {

  static Future<dynamic> getReAssignedTasks(String teamID) async {
    try {
      var authHeader = await generateAuthHeader();

      var tasks = <TeamMemberTask>[];

      http.Response response = await http.get(
        apiEndpoint + "team-task/team-tasks/partially-completed/" + teamID,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          HttpHeaders.authorizationHeader: authHeader,
        },
      ).catchError((error) =>
      {
        print(error.toString())
      });

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        for (var item in jsonData) {
          tasks.add(TeamMemberTask.formJson(item));
        }
        return tasks;
      }else{
        return 1;
      }
    }catch(e){
      return -1;
    }
  }

}