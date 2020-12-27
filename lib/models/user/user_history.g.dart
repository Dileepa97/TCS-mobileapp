// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserHistory _$UserHistoryFromJson(Map<String, dynamic> json) {
  return UserHistory(
    json['id'] as String,
    json['username'] as String,
    json['fullName'] as String,
    json['telephoneNumber'] as String,
    json['email'] as String,
    json['title'] == null
        ? null
        : Title.fromJson(json['title'] as Map<String, dynamic>),
    json['probationary'] as bool,
  );
}

Map<String, dynamic> _$UserHistoryToJson(UserHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'fullName': instance.fullName,
      'telephoneNumber': instance.telephoneNumber,
      'email': instance.email,
      'title': instance.title?.toJson(),
      'probationary': instance.probationary,
    };
