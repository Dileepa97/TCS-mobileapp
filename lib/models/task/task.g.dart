// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    taskId: json['taskId'] as String,
    taskName: json['taskName'] as String,
    estimatedHours: json['estimatedHours'] as double,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    taskStatus: _$enumDecodeNullable(_$TaskStatusEnumMap, json['taskStatus']),
    productId: json['productId'] as String,
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'taskId': instance.taskId,
      'taskName': instance.taskName,
      'estimatedHours': instance.estimatedHours,
      'createdAt': instance.createdAt?.toIso8601String(),
      'taskStatus': _$TaskStatusEnumMap[instance.taskStatus],
      'productId': instance.productId,
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

const _$TaskStatusEnumMap = {
  TaskStatus.NEW: 'NEW',
  TaskStatus.ONGOING: 'ONGOING',
  TaskStatus.COMPLETED: 'COMPLETED',
  TaskStatus.PARTIALLY_COMPLETED: 'PARTIALLY_COMPLETED',
};
