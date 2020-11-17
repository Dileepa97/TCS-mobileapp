import 'package:json_annotation/json_annotation.dart';
import 'package:timecapturesystem/models/user/role.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
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

  Set<Role> roles;

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

  factory User.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
