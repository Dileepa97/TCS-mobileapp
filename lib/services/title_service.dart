import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:quartet/quartet.dart';
import 'package:timecapturesystem/models/auth/title.dart';
import 'package:timecapturesystem/services/utils.dart';

String contentTypeHeader = 'application/json';

final storage = FlutterSecureStorage();

var apiEndpoint = DotEnv().env['API_URL'].toString();

var titleAPI = apiEndpoint + 'titles/';

class TitleService {
  static Future<dynamic> getTitles() async {
    var res = await http.get(titleAPI,
        headers: {HttpHeaders.contentTypeHeader: contentTypeHeader});
    var titles = [];

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      for (Map i in data) {
        titles.add(Title.fromJson(i));
      }
    }
    return titles;
  }

  static Future<dynamic> addTitle(String title) async {
    var authHeader = await generateAuthHeader();
    var body = jsonEncode({
      "name": titleCase(title),
    });
    http.Response res = await http.post(
      titleAPI,
      body: body,
      headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      },
    );
    return res.statusCode;
  }

  static Future<dynamic> deleteTitle(deletingTitle) async {
    var authHeader = await generateAuthHeader();
    http.Response res = await http.delete(
      titleAPI + 'deleteByName/' + deletingTitle,
      headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      },
    );
    return res.statusCode;
  }

  static Future<dynamic> changeTitle(
      Title currentTitle, String newTitle) async {
    var body = jsonEncode({"name": titleCase(newTitle), "id": currentTitle.id});
    var authHeader = await generateAuthHeader();
    http.Response res = await http.put(
      titleAPI,
      body: body,
      headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      },
    );
    return res.statusCode;
  }
}
