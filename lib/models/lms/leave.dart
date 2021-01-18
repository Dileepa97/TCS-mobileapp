import 'package:json_annotation/json_annotation.dart';

import 'leave_method.dart';
import 'leave_status.dart';
import 'leave_type.dart';

part 'leave.g.dart';

@JsonSerializable()
class Leave {
  String id;
  String title;
  LeaveType type;
  String description;
  DateTime reqDate;
  DateTime startDate;
  DateTime endDate;
  LeaveMethod startDayMethod;
  LeaveMethod endDayMethod;
  double days;
  double takenDays;
  LeaveStatus status;
  String rejectReason;
  String userId;
  String attachmentURL;

  Leave(
      this.id,
      this.title,
      this.type,
      this.description,
      this.reqDate,
      this.startDate,
      this.endDate,
      this.startDayMethod,
      this.endDayMethod,
      this.days,
      this.takenDays,
      this.status,
      this.rejectReason,
      this.userId,
      this.attachmentURL);

  factory Leave.fromJson(Map<String, dynamic> data) => _$LeaveFromJson(data);

  Map<String, dynamic> toJson() => _$LeaveToJson(this);
}
