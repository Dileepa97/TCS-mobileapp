import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/leave/LeaveResponse.dart';
import 'package:timecapturesystem/models/leave/LeaveStatus.dart';
import 'package:timecapturesystem/models/leave/LeaveType.dart';

class LeaveCard extends StatelessWidget {
  LeaveCard({this.item});
  final LeaveResponse item;

  Color statusColor(LeaveStatus status) {
    if (status == LeaveStatus.REQUESTED) {
      return Colors.blue;
    } else if (status == LeaveStatus.ACCEPTED) {
      return Colors.green;
    } else if (status == LeaveStatus.REJECTED) {
      return Colors.red;
    } else if (status == LeaveStatus.CANCELED) {
      return Colors.grey;
    } else
      return Colors.black;
  }

  Icon typeIcon(LeaveType type) {
    if (type == LeaveType.No_Pay) {
      return Icon(
        Icons.money_off,
        size: 20,
      );
    } else if (type == LeaveType.Sick) {
      return Icon(
        Icons.local_hospital,
        size: 20,
      );
    } else if (type == LeaveType.Maternity) {
      return Icon(
        Icons.pregnant_woman,
        size: 20,
      );
    } else if (type == LeaveType.Annual) {
      return Icon(
        Icons.date_range,
        size: 20,
      );
    } else if (type == LeaveType.Casual) {
      return Icon(
        Icons.directions_walk,
        size: 20,
      );
    } else
      return null;
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      height: 110,
      child: Card(
        shadowColor: Colors.black54,
        color: Colors.white,
        elevation: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 50,
              width: 50,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Image.asset('images/user.png'), //todo: user image
            ),
            SizedBox(
              height: 50,
              child: VerticalDivider(
                thickness: 1,
                color: Colors.black12,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          this.item.userId, //todo: user name
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          EnumToString.convertToString(this.item.leaveStatus),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: statusColor(this.item.leaveStatus),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        typeIcon(this.item.leaveType),
                        SizedBox(
                          width: 10,
                        ),
                        Text(EnumToString.convertToString(this.item.leaveType) +
                            ' leave'),
                      ],
                    ),
                    Text(
                      this.item.leaveTitle,
                      style: TextStyle(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
