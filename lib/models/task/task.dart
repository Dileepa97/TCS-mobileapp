import 'package:json_annotation/json_annotation.dart';
import 'package:timecapturesystem/models/task/task_status.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  String taskId;

  String taskName;

  double estimatedHours;

  DateTime createdAt;

  TaskStatus taskStatus;

  String productId;

  Task(
      {this.taskId,
      this.taskName,
      this.estimatedHours,
      this.createdAt,
      this.taskStatus,
      this.productId});

  factory Task.fromJson(Map<String, dynamic> data) => _$TaskFromJson(data);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
