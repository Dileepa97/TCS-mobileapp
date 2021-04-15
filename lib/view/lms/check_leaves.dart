import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/lms/leave_method.dart';
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
    } else if (status == LeaveStatus.ONGOING_CANCELLED) {
      return Colors.black;
    } else if (status == LeaveStatus.ONGOING_CANCEL_REQUESTED) {
      return Colors.blueAccent;
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
        Icons.label_important_outline,
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
        Icons.baby_changing_station_outlined,
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
    } else if (type == LeaveType.EXTENDED_ANNUAL) {
      return Icon(
        Icons.event_note,
        size: 20,
      );
    } else if (type == LeaveType.EXTENDED_MEDICAL) {
      return Icon(
        Icons.queue,
        size: 20,
      );
    } else
      return null;
  }
}

class CheckMethod {
  static String methodString(LeaveMethod method) {
    if (method == LeaveMethod.FIRST_HALF) {
      return ' Morning';
    } else if (method == LeaveMethod.SECOND_HALF) {
      return ' Afternoon';
    } else
      return ' Full Day';
  }

  static String convertMethodName(String method) {
    if (method == 'Morning') {
      return 'FIRST_HALF';
    } else if (method == 'Afternoon') {
      return 'SECOND_HALF';
    } else
      return 'FULL';
  }
}
