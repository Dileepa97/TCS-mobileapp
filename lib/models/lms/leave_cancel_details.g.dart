// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_cancel_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveCancelDetails _$LeaveCancelDetailsFromJson(Map<String, dynamic> json) {
  return LeaveCancelDetails(
    json['id'] as String,
    json['leave'] == null
        ? null
        : Leave.fromJson(json['leave'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LeaveCancelDetailsToJson(LeaveCancelDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'leave': instance.leave,
    };
