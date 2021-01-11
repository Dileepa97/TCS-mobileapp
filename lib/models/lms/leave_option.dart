import 'package:enum_to_string/enum_to_string.dart';
import 'package:json_annotation/json_annotation.dart';

import 'leave_type.dart';
part 'leave_option.g.dart';

@JsonSerializable()
class LeaveOption {
  LeaveType type;
  double allowedDays;
  double requestedDays;
  double approvedDays;
  double takenDays;

  LeaveOption(this.type, this.allowedDays, this.requestedDays,
      this.approvedDays, this.takenDays);

  factory LeaveOption.fromJson(Map<String, dynamic> data) =>
      _$LeaveOptionFromJson(data);

  Map<String, dynamic> toJson() => _$LeaveOptionToJson(this);
}
