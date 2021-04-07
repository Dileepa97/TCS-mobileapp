import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timecapturesystem/models/task/task.dart';

String contentTypeHeader = 'application/json';
var apiEndpoint = DotEnv().env['C_API_URL'].toString();

class TeamMemberTaskService {

  static Future<List<Task>> getTeamMemberTasks(String teamMemberID) async {

    var tasks = <Task>[];

    http.Response response = await http.get(
      apiEndpoint+"/team-member-task",
      headers: {
        HttpHeaders.contentTypeHeader: contentTypeHeader
      }).catchError((error)=>{
      print(error.toString())
    });

    if(response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      for (var item in jsonData) {
        tasks.add(Task.formJson(item));
      }
    }
    return tasks;
  }


  static Future<List<Task>> getOngoingTasks(String teamMemberID) async {

    var tasks = <Task>[];

    var body  = jsonEncode({
      "teamMemberId" : teamMemberID
    });

    http.Response response = await http.post(
        apiEndpoint+"team-member-task/ongoing",
        headers: {
          "Accept": "application/json",
          "content-type":"application/json"
        },
        body: body
    ).catchError((error)=>{
      print(error.toString())
    });

    if(response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      for (var item in jsonData) {
        tasks.add(Task.formJson(item));
      }
    }
    return tasks;
  }

  static Future<List<Task>> getPartiallyCompletedTasks(String teamMemberID) async {

    var tasks = <Task>[];

    var body  = jsonEncode({
      "teamMemberId" : teamMemberID
    });

    http.Response response = await http.post(
        apiEndpoint+"team-member-task/partially-completed",
        headers: {
          "Accept": "application/json",
          "content-type":"application/json"
        },
        body: body
    ).catchError((error)=>{
      print(error.toString())
    });

    if(response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      for (var item in jsonData) {
        tasks.add(Task.formJson(item));
      }
    }
    return tasks;
  }

  static Future<List<Task>> getCompletedTasks(String teamMemberID) async {

    var tasks = <Task>[];

    var body  = jsonEncode({
      "teamMemberId" : teamMemberID
    });

    http.Response response = await http.post(
        apiEndpoint+"team-member-task/completed",
        headers: {
          "Accept": "application/json",
          "content-type":"application/json"
        },
        body: body
    ).catchError((error)=>{
      print(error.toString())
    });


    if(response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      for (var item in jsonData) {
        tasks.add(Task.formJson(item));
      }
    }
    return tasks;
  }




}