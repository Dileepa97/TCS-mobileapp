// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_day_allocation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveDayAllocation _$LeaveDayAllocationFromJson(Map<String, dynamic> json) {
  return LeaveDayAllocation(
    json['id'] as String,
    _$enumDecodeNullable(_$LeaveTypeEnumMap, json['type']),
    (json['allowedDays'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$LeaveDayAllocationToJson(LeaveDayAllocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$LeaveTypeEnumMap[instance.type],
      'allowedDays': instance.allowedDays,
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
