// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Leave _$LeaveFromJson(Map<String, dynamic> json) {
  return Leave(
    json['id'] as String,
    json['title'] as String,
    _$enumDecodeNullable(_$LeaveTypeEnumMap, json['type']),
    json['description'] as String,
    json['reqDate'] == null ? null : DateTime.parse(json['reqDate'] as String),
    json['startDate'] == null
        ? null
        : DateTime.parse(json['startDate'] as String),
    json['endDate'] == null ? null : DateTime.parse(json['endDate'] as String),
    _$enumDecodeNullable(_$LeaveMethodEnumMap, json['startDayMethod']),
    _$enumDecodeNullable(_$LeaveMethodEnumMap, json['endDayMethod']),
    (json['days'] as num)?.toDouble(),
    (json['takenDays'] as num)?.toDouble(),
    _$enumDecodeNullable(_$LeaveStatusEnumMap, json['status']),
    json['rejectReason'] as String,
    json['userId'] as String,
    json['attachmentURL'] as String,
  );
}

Map<String, dynamic> _$LeaveToJson(Leave instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': _$LeaveTypeEnumMap[instance.type],
      'description': instance.description,
      'reqDate': instance.reqDate?.toIso8601String(),
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'startDayMethod': _$LeaveMethodEnumMap[instance.startDayMethod],
      'endDayMethod': _$LeaveMethodEnumMap[instance.endDayMethod],
      'days': instance.days,
      'takenDays': instance.takenDays,
      'status': _$LeaveStatusEnumMap[instance.status],
      'rejectReason': instance.rejectReason,
      'userId': instance.userId,
      'attachmentURL': instance.attachmentURL,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$LeaveTypeEnumMap = {
  LeaveType.MEDICAL: 'MEDICAL',
  LeaveType.MATERNITY: 'MATERNITY',
  LeaveType.PATERNITY: 'PATERNITY',
  LeaveType.CASUAL: 'CASUAL',
  LeaveType.ANNUAL: 'ANNUAL',
  LeaveType.LIEU: 'LIEU',
  LeaveType.EXTENDED_ANNUAL: 'EXTENDED_ANNUAL',
  LeaveType.EXTENDED_MEDICAL: 'EXTENDED_MEDICAL',
};

const _$LeaveMethodEnumMap = {
  LeaveMethod.FIRST_HALF: 'FIRST_HALF',
  LeaveMethod.SECOND_HALF: 'SECOND_HALF',
  LeaveMethod.FULL: 'FULL',
  LeaveMethod.NO: 'NO',
};

const _$LeaveStatusEnumMap = {
  LeaveStatus.REQUESTED: 'REQUESTED',
  LeaveStatus.ACCEPTED: 'ACCEPTED',
  LeaveStatus.REJECTED: 'REJECTED',
  LeaveStatus.CANCELLED: 'CANCELLED',
  LeaveStatus.ONGOING: 'ONGOING',
  LeaveStatus.ONGOING_CANCELLED: 'ONGOING_CANCELLED',
  LeaveStatus.EXPIRED: 'EXPIRED',
};
