import 'package:timecapturesystem/models/leave/LeaveStatus.dart';

class LeaveResponse {
  String leaveId;
  String leaveType;
  String leaveDescription;
  DateTime reqDate;
  DateTime leaveStartDate;
  DateTime leaveEndDate;
  int leaveCount;
  LeaveStatus leaveStatus;
  String userId;

  LeaveResponse(
      this.leaveId,
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
        json['leaveType'] as String,
        json['leaveDescription'] as String,
        DateTime.tryParse(json['reqDate']),
        DateTime.tryParse(json['leaveStartDate']),
        DateTime.tryParse(json['leaveEndDate']),
        // json['leaveStartDate'] as DateTime,
        //json['leaveEndDate'] as DateTime,
        json['leaveCount'] as int,
        json['leaveStatus'] as LeaveStatus,
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
