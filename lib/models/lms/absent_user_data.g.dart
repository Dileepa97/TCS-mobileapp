// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absent_user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AbsentUser _$AbsentUserFromJson(Map<String, dynamic> json) {
  return AbsentUser(
    json['userId'] as String,
    _$enumDecodeNullable(_$LeaveMethodEnumMap, json['method']),
    _$enumDecodeNullable(_$LeaveTypeEnumMap, json['type']),
    _$enumDecodeNullable(_$LeaveStatusEnumMap, json['status']),
    json['leaveId'] as String,
  );
}

Map<String, dynamic> _$AbsentUserToJson(AbsentUser instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'method': _$LeaveMethodEnumMap[instance.method],
      'type': _$LeaveTypeEnumMap[instance.type],
      'status': _$LeaveStatusEnumMap[instance.status],
      'leaveId': instance.leaveId,
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

const _$LeaveMethodEnumMap = {
  LeaveMethod.FIRST_HALF: 'FIRST_HALF',
  LeaveMethod.SECOND_HALF: 'SECOND_HALF',
  LeaveMethod.FULL: 'FULL',
  LeaveMethod.NO: 'NO',
};

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

const _$LeaveStatusEnumMap = {
  LeaveStatus.REQUESTED: 'REQUESTED',
  LeaveStatus.ACCEPTED: 'ACCEPTED',
  LeaveStatus.REJECTED: 'REJECTED',
  LeaveStatus.CANCELLED: 'CANCELLED',
  LeaveStatus.ONGOING: 'ONGOING',
  LeaveStatus.ONGOING_CANCELED: 'ONGOING_CANCELED',
  LeaveStatus.EXPIRED: 'EXPIRED',
};
