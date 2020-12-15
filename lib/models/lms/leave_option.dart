import 'package:enum_to_string/enum_to_string.dart';

import 'leave_type.dart';

class LeaveOption {
  LeaveType type;
  double allowedDays;
  double requestedDays;
  double approvedDays;
  double takenDays;

  LeaveOption(this.type, this.allowedDays, this.requestedDays,
      this.approvedDays, this.takenDays);

  factory LeaveOption.fromJson(dynamic json) {
    var leaveOptionRes = LeaveOption(
      EnumToString.fromString(LeaveType.values, json['type']),
      json['allowedDays'] as double,
      json['requestedDays'] as double,
      json['approvedDays'] as double,
      json['takenDays'] as double,
    );

    return leaveOptionRes;
  }
}
