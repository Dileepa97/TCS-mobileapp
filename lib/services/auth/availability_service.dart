import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

var apiEndpoint = DotEnv().env['API_URL'].toString();

var authAPI = apiEndpoint + 'availability/';
var titleAPI = apiEndpoint + 'titles/';

String contentTypeHeader = 'application/json';

final storage = FlutterSecureStorage();

class AvailabilityService {
  // static forgotPassword(String email) async {
  //   var jsonBody = jsonEncode({
  //     "email": email,
  //   });
  //   var res = await http.post(authAPI + "password-reset-req-mobile",
  //       body: jsonBody,
  //       headers: {HttpHeaders.contentTypeHeader: contentTypeHeader});
  //
  //   return res.statusCode;
  // }

}
