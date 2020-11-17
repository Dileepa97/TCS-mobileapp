import 'dart:collection';

class User {
  String _id;

  String _username;

  String _fullName;

  String _profileImageURL;

  String _telephoneNumber;

  String _email;

  String _password;

  bool _isVerified;

  bool _isEmailVerified;

  int _resetCode;

  int _emailVerificationCode;

  bool _updated = false;
  Set<dynamic> _roles = new HashSet<dynamic>();
  int _highestRoleIndex = 0;

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  int get highestRoleIndex => _highestRoleIndex;

  set highestRoleIndex(int value) {
    _highestRoleIndex = value;
  }

  Set<dynamic> get roles => _roles;

  set roles(Set<dynamic> value) {
    _roles = value;
  }

  bool get updated => _updated;

  set updated(bool value) {
    _updated = value;
  }

  int get emailVerificationCode => _emailVerificationCode;

  set emailVerificationCode(int value) {
    _emailVerificationCode = value;
  }

  int get resetCode => _resetCode;

  set resetCode(int value) {
    _resetCode = value;
  }

  bool get isEmailVerified => _isEmailVerified;

  set isEmailVerified(bool value) {
    _isEmailVerified = value;
  }

  bool get isVerified => _isVerified;

  set isVerified(bool value) {
    _isVerified = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get telephoneNumber => _telephoneNumber;

  set telephoneNumber(String value) {
    _telephoneNumber = value;
  }

  String get profileImageURL => _profileImageURL;

  set profileImageURL(String value) {
    _profileImageURL = value;
  }

  String get fullName => _fullName;

  set fullName(String value) {
    _fullName = value;
  }
}
