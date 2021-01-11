import 'package:enum_to_string/enum_to_string.dart';

import 'leave_method.dart';
import 'leave_status.dart';
import 'leave_type.dart';

class LeaveResponse {
  String leaveId;
  String leaveTitle;
  LeaveType leaveType;
  String leaveDescription;
  DateTime reqDate;
  DateTime leaveStartDate;
  DateTime leaveEndDate;
  LeaveMethod startDayMethod;
  LeaveMethod endDayMethod;
  double leaveCount;
  double takenDays;
  LeaveStatus leaveStatus;
  String rejectReason;
  String userId;
  String attachmentURL;

  LeaveResponse(
      this.leaveId,
      this.leaveTitle,
      this.leaveType,
      this.leaveDescription,
      this.reqDate,
      this.leaveStartDate,
      this.leaveEndDate,
      this.startDayMethod,
      this.endDayMethod,
      this.leaveCount,
      this.takenDays,
      this.leaveStatus,
      this.rejectReason,
      this.userId,
      this.attachmentURL);

  factory LeaveResponse.fromJson(dynamic json) {
    var leaveRes = LeaveResponse(
        json['id'] as String,
        json['title'] as String,
        EnumToString.fromString(LeaveType.values, json['type']),
        json['description'] as String,
        DateTime.tryParse(json['reqDate']),
        DateTime.tryParse(json['startDate']),
        json['endDate'] == null ? null : DateTime.tryParse(json['endDate']),
        EnumToString.fromString(LeaveMethod.values, json['startDayMethod']),
        EnumToString.fromString(LeaveMethod.values, json['endDayMethod']),
        json['days'] as double,
        json['takenDays'] as double,
        EnumToString.fromString(LeaveStatus.values, json['status']),
        json['rejectReason'] as String,
        json['userId'] as String,
        json['attachmentURL'] as String);

    // authRes.roles.forEach((element) {
    //   element = "$element";
    // });
    return leaveRes;
  }

  Map<String, dynamic> toJson() => {
        "leaveId": leaveId,
        "leaveType": leaveType,
        "leaveDescription": leaveDescription,
        "reqDate": reqDate,
        "leaveStartDate": leaveStartDate,
        "leaveEndDate": leaveEndDate,
        "leaveCount": leaveCount,
        "leaveStatus": leaveStatus,
        "userId": userId
      };
}
