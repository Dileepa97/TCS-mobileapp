// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['id'] as String,
    json['username'] as String,
    json['fullName'] as String,
    json['profileImageURL'] as String,
    json['telephoneNumber'] as String,
    json['email'] as String,
    json['password'] as String,
    json['verified'] as bool,
    json['emailVerified'] as bool,
    json['resetCode'] as int,
    json['emailVerificationCode'] as int,
    json['updated'] as bool,
    (json['roles'] as List)
        ?.map(
            (e) => e == null ? null : Role.fromJson(e as Map<String, dynamic>))
        ?.toSet(),
    json['highestRoleIndex'] as int,
    json['title'] == null
        ? null
        : Title.fromJson(json['title'] as Map<String, dynamic>),
    json['probationary'] as bool,
    json['gender'] as String,
    json['teamId'] as String,
  )..teamId = json['teamId'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'fullName': instance.fullName,
      'profileImageURL': instance.profileImageURL,
      'telephoneNumber': instance.telephoneNumber,
      'email': instance.email,
      'password': instance.password,
      'verified': instance.verified,
      'emailVerified': instance.emailVerified,
      'resetCode': instance.resetCode,
      'emailVerificationCode': instance.emailVerificationCode,
      'updated': instance.updated,
      'roles': instance.roles?.map((e) => e?.toJson())?.toList(),
      'highestRoleIndex': instance.highestRoleIndex,
      'title': instance.title?.toJson(),
      'probationary': instance.probationary,
      'gender': instance.gender,
      'teamId': instance.teamId,
    };
