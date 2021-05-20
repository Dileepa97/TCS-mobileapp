import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timecapturesystem/models/team/team.dart';
import 'package:timecapturesystem/services/other/utils.dart';

String contentTypeHeader = 'application/json';
var apiEndpoint = DotEnv().env['API_URL'].toString();

class TeamService {

  static dynamic getTeamById(String teamId) async {

    try {
      var authHeader = await generateAuthHeader();
      Team team;

      http.Response response = await http.get(apiEndpoint + "teams/" + teamId,
          headers: {
            HttpHeaders.authorizationHeader: authHeader,
            HttpHeaders.contentTypeHeader: contentTypeHeader
          }).catchError((error) => {print(error.toString())});

      print(response.statusCode);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return new Team.formJson(jsonData);
      } else {
        return 1;
      }
    }catch(e){
      return -1;
    }
  }
  
}