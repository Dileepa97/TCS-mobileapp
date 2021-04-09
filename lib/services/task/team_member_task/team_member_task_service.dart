import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timecapturesystem/models/task/team_member_task.dart';

String contentTypeHeader = 'application/json';
var apiEndpoint = DotEnv().env['API_URL'].toString();

class TeamMemberTaskService {

  static Future<List<TeamMemberTask>> getTeamMemberTasks(String teamMemberID) async {

    var tasks = <TeamMemberTask>[];

    http.Response response = await http.get(apiEndpoint + "/team-member-task",
        headers: {
          HttpHeaders.contentTypeHeader: contentTypeHeader
        }).catchError((error) => {print(error.toString())});

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      for (var item in jsonData) {
        tasks.add(TeamMemberTask.formJson(item));
        // tasks.add(Task.formJson(item));
      }
    }
    return tasks;
  }


  static Future<List<TeamMemberTask>> getOngoingTasks(String teamMemberID) async {

    var tasks = <TeamMemberTask>[];

//    var body  = jsonEncode({
//      "teamMemberId" : teamMemberID
//    });

    print(apiEndpoint);

    http.Response response = await http.get(
        apiEndpoint+"team-member-task/ongoing/"+teamMemberID,
        headers: {
          "Accept": "application/json",
          "content-type":"application/json"
        },
    ).catchError((error)=>{
      print(error.toString())
    });

    print(response.body);

    if(response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      for (var item in jsonData) {
        tasks.add(TeamMemberTask.formJson(item));
      }
    }
    return tasks;
  }

  static Future<List<TeamMemberTask>> getPartiallyCompletedTasks(String teamMemberID) async {

    var tasks = <TeamMemberTask>[];

    http.Response response = await http.get(
        apiEndpoint+"team-member-task/partially-completed/"+teamMemberID,
        headers: {
          "Accept": "application/json",
          "content-type":"application/json"
        },
    ).catchError((error)=>{
      print(error.toString())
    });

    print(response.body);

    if(response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      for (var item in jsonData) {
        tasks.add(TeamMemberTask.formJson(item));
      }
    }
    return tasks;
  }

  static Future<List<TeamMemberTask>> getCompletedTasks(String teamMemberID) async {

    var tasks = <TeamMemberTask>[];


    http.Response response = await http.get(
        apiEndpoint+"team-member-task/completed/"+teamMemberID,
        headers: {
          "Accept": "application/json",
          "content-type":"application/json"
        },
    ).catchError((error)=>{
      print(error.toString())
    });

    print(response.body);


    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      for (var item in jsonData) {
        tasks.add(TeamMemberTask.formJson(item));
        // tasks.add(Task.formJson(item));
      }
    }
    return tasks;
  }
}
