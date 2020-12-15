import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/lms/leave_response.dart';
import '../check_leaves.dart';

class LeaveCard extends StatelessWidget {
  LeaveCard({this.item});
  final LeaveResponse item;

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
