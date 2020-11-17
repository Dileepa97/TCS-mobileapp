import 'dart:collection';

class User {
  String id;

  String username;

  String fullName;

  String profileImageURL;

  String telephoneNumber;

  String email;

  String password;

  bool isVerified;

  bool isEmailVerified;

  int resetCode;

  int emailVerificationCode;

  bool updated = false;

  Set<dynamic> roles = new HashSet<dynamic>();

  int highestRoleIndex;
}
