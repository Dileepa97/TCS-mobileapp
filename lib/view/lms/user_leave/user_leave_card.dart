import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/lms/leave_response.dart';

import '../check_leaves.dart';

class UserLeaveCard extends StatelessWidget {
  UserLeaveCard({this.item});
  final LeaveResponse item;

  @override
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
                          'Title : ' + this.item.leaveTitle,
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          EnumToString.convertToString(this.item.leaveStatus),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CheckStatus(status: this.item.leaveStatus)
                                .statusColor(),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        CheckType(type: this.item.leaveType).typeIcon(),
                        SizedBox(
                          width: 10,
                        ),
                        Text(EnumToString.convertToString(this.item.leaveType) +
                            ' leave'),
                      ],
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
