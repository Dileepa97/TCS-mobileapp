import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/lms/leave_status.dart';
import 'package:timecapturesystem/models/lms/leave_type.dart';

class CheckStatus {
  LeaveStatus status;

  CheckStatus({this.status});

  Color statusColor() {
    if (status == LeaveStatus.REQUESTED) {
      return Colors.blue;
    } else if (status == LeaveStatus.ACCEPTED) {
      return Colors.green;
    } else if (status == LeaveStatus.REJECTED) {
      return Colors.red;
    } else if (status == LeaveStatus.CANCELLED) {
      return Colors.grey;
    } else if (status == LeaveStatus.ONGOING) {
      return Colors.orange;
    } else if (status == LeaveStatus.EXPIRED) {
      return Colors.black;
    } else
      return Colors.black;
  }
}

class CheckType {
  LeaveType type;

  CheckType({this.type});

  Icon typeIcon() {
    if (type == LeaveType.LIEU) {
      return Icon(
        Icons.arrow_forward,
        size: 20,
      );
    } else if (type == LeaveType.MEDICAL) {
      return Icon(
        Icons.local_hospital,
        size: 20,
      );
    } else if (type == LeaveType.MATERNITY) {
      return Icon(
        Icons.pregnant_woman,
        size: 20,
      );
    } else if (type == LeaveType.PATERNITY) {
      return Icon(
        Icons.pregnant_woman,
        size: 20,
      );
    } else if (type == LeaveType.ANNUAL) {
      return Icon(
        Icons.date_range,
        size: 20,
      );
    } else if (type == LeaveType.CASUAL) {
      return Icon(
        Icons.directions_walk,
        size: 20,
      );
    } else
      return null;
  }
}
