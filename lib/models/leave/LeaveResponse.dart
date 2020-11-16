import 'package:enum_to_string/enum_to_string.dart';
import 'package:timecapturesystem/models/leave/LeaveStatus.dart';
import 'package:timecapturesystem/models/leave/LeaveType.dart';

class LeaveResponse {
  String leaveId;
  String leaveTitle;
  LeaveType leaveType;
  String leaveDescription;
  DateTime reqDate;
  DateTime leaveStartDate;
  DateTime leaveEndDate;
  double leaveCount;
  LeaveStatus leaveStatus;
  String userId;

  LeaveResponse(
      this.leaveId,
      this.leaveTitle,
      this.leaveType,
      this.leaveDescription,
      this.reqDate,
      this.leaveStartDate,
      this.leaveEndDate,
      this.leaveCount,
      this.leaveStatus,
      this.userId);

  factory LeaveResponse.fromJson(dynamic json) {
    var leaveRes = LeaveResponse(
        json['leaveId'] as String,
        json['leaveTitle'] as String,
        EnumToString.fromString(LeaveType.values, json['leaveType']),
        json['leaveDescription'] as String,
        DateTime.tryParse(json['reqDate']),
        DateTime.tryParse(json['leaveStartDate']),
        DateTime.tryParse(json['leaveEndDate']),
        // json['leaveStartDate'] as DateTime,
        //json['leaveEndDate'] as DateTime,
        json['leaveDays'] as double,
        EnumToString.fromString(LeaveStatus.values, json['leaveStatus']),
        json['userId'] as String);

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