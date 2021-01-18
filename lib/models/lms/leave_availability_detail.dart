import 'package:json_annotation/json_annotation.dart';

import 'leave_option.dart';

part 'leave_availability_detail.g.dart';

@JsonSerializable()
class LeaveAvailabilityDetail {
  String id;
  String userId;
  int year;
  List<LeaveOption> leaveOptionList;

  LeaveAvailabilityDetail(
      this.id, this.userId, this.year, this.leaveOptionList);

  factory LeaveAvailabilityDetail.fromJson(Map<String, dynamic> data) =>
      _$LeaveAvailabilityDetailFromJson(data);

  Map<String, dynamic> toJson() => _$LeaveAvailabilityDetailToJson(this);
}
