// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authRes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) {
  return AuthResponse(
    json['token'] as String,
    json['type'] as String,
    json['id'] as String,
    json['message'] as String,
    json['tokenExpirationDate'] == null
        ? null
        : DateTime.parse(json['tokenExpirationDate'] as String),
  );
}

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'type': instance.type,
      'id': instance.id,
      'message': instance.message,
      'tokenExpirationDate': instance.tokenExpirationDate?.toIso8601String(),
    };
