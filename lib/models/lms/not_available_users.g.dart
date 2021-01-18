// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'not_available_users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotAvailableUsers _$NotAvailableUsersFromJson(Map<String, dynamic> json) {
  return NotAvailableUsers(
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
    (json['users'] as List)
        ?.map((e) =>
            e == null ? null : AbsentUser.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$NotAvailableUsersToJson(NotAvailableUsers instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'users': instance.users,
    };
