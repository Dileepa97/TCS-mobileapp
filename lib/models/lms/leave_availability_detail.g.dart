// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_availability_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveAvailabilityDetail _$LeaveAvailabilityDetailFromJson(
    Map<String, dynamic> json) {
  return LeaveAvailabilityDetail(
    json['id'] as String,
    json['userId'] as String,
    json['year'] as int,
    (json['leaveOptionList'] as List)
        ?.map((e) =>
            e == null ? null : LeaveOption.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$LeaveAvailabilityDetailToJson(
        LeaveAvailabilityDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'year': instance.year,
      'leaveOptionList': instance.leaveOptionList,
    };
