import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notification {
  String id;
  String userId;
  String referencedId;
  String title;
  String category;
  String content;
  DateTime createdAt;
  String seen;
  String instruction;

  Notification(this.id, this.userId, this.referencedId, this.title,
      this.category, this.content, this.createdAt, this.seen, this.instruction);

  factory Notification.fromJson(Map<String, dynamic> data) =>
      _$NotificationFromJson(data);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);

  @override
  String toString() {
    return 'Notification{id: $id, userId: $userId, referencedId: $referencedId, title: $title, category: $category, content: $content, createdAt: $createdAt, seen: $seen, instruction: $instruction}';
  }
}
