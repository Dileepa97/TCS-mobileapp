import 'package:json_annotation/json_annotation.dart';

import 'leave_method.dart';
import 'leave_status.dart';
import 'leave_type.dart';

part 'absent_user_data.g.dart';

@JsonSerializable()
class AbsentUser {
  String userId;

  LeaveMethod method;

  LeaveType type;

  LeaveStatus status;

  String leaveId;

  AbsentUser(this.userId, this.method, this.type, this.status, this.leaveId);

  factory AbsentUser.fromJson(Map<String, dynamic> data) =>
      _$AbsentUserFromJson(data);

  Map<String, dynamic> toJson() => _$AbsentUserToJson(this);
}
