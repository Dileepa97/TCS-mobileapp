import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timecapturesystem/models/task/team_member_task.dart';
import 'package:timecapturesystem/services/other/utils.dart';

String contentTypeHeader = 'application/json';
var apiEndpoint = DotEnv().env['API_URL'].toString();

class TeamMemberTaskService {

  static Future<dynamic> getTeamMemberTasks(String teamMemberID) async {

    try {
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
        return tasks;
      }else{
        return 1;
      }

    }catch(e){
      return -1;
    }
  }


  static Future<dynamic> getOngoingTasks(String teamMemberID) async {

    try {
      var tasks = <TeamMemberTask>[];

      var authHeader = await generateAuthHeader();

      http.Response response = await http.get(
        apiEndpoint + "team-member-task/ongoing/" + teamMemberID,
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

  static Future<dynamic> getPartiallyCompletedTasks(String teamMemberID) async {

    try {
      var tasks = <TeamMemberTask>[];

      var authHeader = await generateAuthHeader();

      http.Response response = await http.get(
        apiEndpoint + "team-member-task/partially-completed/" + teamMemberID,
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

  static Future<dynamic> getCompletedTasks(String teamMemberID) async {

    try {
      var tasks = <TeamMemberTask>[];

      var authHeader = await generateAuthHeader();

      http.Response response = await http.get(
        apiEndpoint + "team-member-task/completed/" + teamMemberID,
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

  static Future<dynamic> getReAssignedTasks(String teamMemberID) async {
    try {
      var tasks = <TeamMemberTask>[];

      var authHeader = await generateAuthHeader();

      http.Response response = await http.get(
        apiEndpoint + "team-member-task/re-assigned/" + teamMemberID,
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
