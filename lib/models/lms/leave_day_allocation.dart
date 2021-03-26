import 'package:json_annotation/json_annotation.dart';
import 'package:timecapturesystem/models/lms/leave_type.dart';

part 'leave_day_allocation.g.dart';

@JsonSerializable()
class LeaveDayAllocation {
  String id;
  LeaveType type;
  double allowedDays;

  LeaveDayAllocation(this.id, this.type, this.allowedDays);

  factory LeaveDayAllocation.fromJson(Map<String, dynamic> data) =>
      _$LeaveDayAllocationFromJson(data);

  Map<String, dynamic> toJson() => _$LeaveDayAllocationToJson(this);
}
