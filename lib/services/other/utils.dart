import 'storage_service.dart';

Future<String> generateAuthHeader() async {
  var token = await TokenStorageService.jwtOrEmpty;
  if (token != null) {
    return 'Bearer ' + token;
  }
  return null;
}
