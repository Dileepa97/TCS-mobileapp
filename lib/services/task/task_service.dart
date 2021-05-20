import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:timecapturesystem/models/task/task.dart';
import 'package:timecapturesystem/services/other/utils.dart';

String contentTypeHeader = 'application/json';
var apiEndpoint = DotEnv().env['API_URL'].toString();

class TaskService {
  static Future<dynamic> getProductTasks(String productId) async {
    try {
      var authHeader = await generateAuthHeader();

      var tasks = <Task>[];
      http.Response response = await http
          .get(apiEndpoint + "tasks/getAllTasks/" + productId, headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      }).catchError((error) => {print(error.toString())});

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        for (var item in jsonData) {
          tasks.add(new Task.fromJson(item));
        }
        return tasks;
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }

  static Future<bool> addProductTask(Task task) async {
    var authHeader = await generateAuthHeader();

    http.Response response = await http
        .post(apiEndpoint + "tasks/addTask", body: jsonEncode(task), headers: {
      HttpHeaders.authorizationHeader: authHeader,
      HttpHeaders.contentTypeHeader: contentTypeHeader
    }).catchError((error) => {print(error.toString())});

    print(response.statusCode);

    if (response.statusCode == 200) {
      return true;
    } else {
      return null;
    }
  }

  static Future<List<Task>> deleteProductTask(String taskId) async {
    var authHeader = await generateAuthHeader();

    var tasks = <Task>[];
    http.Response response =
        await http.delete(apiEndpoint + "tasks/" + taskId, headers: {
      HttpHeaders.authorizationHeader: authHeader,
      HttpHeaders.contentTypeHeader: contentTypeHeader
    }).catchError((error) => {print(error.toString())});

    print(response);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      for (var item in jsonData) {
        tasks.add(new Task.fromJson(item));
      }
      return tasks;
    } else {
      return null;
    }
  }

  static Future<dynamic> getTasksByProductId(String productId) async {
    try {
      var authHeader = await generateAuthHeader();

      http.Response response = await http
          .get(apiEndpoint + 'tasks/getAllTasks/' + productId, headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      print(response.statusCode);

      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);

        return resBody;
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }

  static Future<dynamic> updateTask(Task task) async {
    try {
      print(task.taskId);

      var authHeader = await generateAuthHeader();

      http.Response response = await http.patch(
        apiEndpoint + 'tasks/' + task.taskId,
        body: jsonEncode(task),
        headers: {
          HttpHeaders.authorizationHeader: authHeader,
          HttpHeaders.contentTypeHeader: contentTypeHeader
        },
      );

      print(response.statusCode);

      if (response.statusCode == 202) {
        var resBody = jsonDecode(response.body);
        return resBody;
      } else {
        return 1;
      }
    } catch (e) {
      print(e);
      return -1;
    }
  }
}
