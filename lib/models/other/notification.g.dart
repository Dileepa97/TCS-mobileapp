// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) {
  return Notification(
    json['id'] as String,
    json['userId'] as String,
    json['referencedId'] as String,
    json['title'] as String,
    json['category'] as String,
    json['content'] as String,
    json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    json['seen'] as bool,
    json['instruction'] as String,
  );
}

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'referencedId': instance.referencedId,
      'title': instance.title,
      'category': instance.category,
      'content': instance.content,
      'createdAt': instance.createdAt?.toIso8601String(),
      'seen': instance.seen,
      'instruction': instance.instruction,
    };
