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

  User(
      this.id,
      this.username,
      this.fullName,
      this.profileImageURL,
      this.telephoneNumber,
      this.email,
      this.password,
      this.isVerified,
      this.isEmailVerified,
      this.resetCode,
      this.emailVerificationCode,
      this.updated,
      this.roles,
      this.highestRoleIndex);
}
