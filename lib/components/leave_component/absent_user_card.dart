import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/leave_component/detail_row.dart';
import 'package:timecapturesystem/components/rounded_button.dart';
import 'package:timecapturesystem/models/lms/absent_user_data.dart';
import 'package:timecapturesystem/models/lms/leave.dart';
import 'package:timecapturesystem/models/lms/leave_method.dart';
import 'package:timecapturesystem/services/lms/leave_service.dart';
import 'package:timecapturesystem/view/lms/admin_leave/admin_leave_detail_screen.dart';
import 'package:timecapturesystem/components/leave_component/leave_user_data_builders.dart';
import 'package:timecapturesystem/view/lms/check_leaves.dart';

class AbsentUserCard extends StatefulWidget {
  final AbsentUser userData;

  const AbsentUserCard({Key key, this.userData}) : super(key: key);
  @override
  _AbsentUserCardState createState() => _AbsentUserCardState();
}

class _AbsentUserCardState extends State<AbsentUserCard> {
  LeaveService _leaveService = LeaveService();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      height: 150,
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
        // border: Border(
        //   bottom: BorderSide(
        //     color: Colors.black12,
        //     width: 1.0,
        //   ),
        // ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              UserProfileImage(
                  userId: widget.userData.userId, height: 35, width: 35),
              UserNameText(
                userId: widget.userData.userId,
                fontSize: 16,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  EnumToString.convertToString(widget.userData.type)
                          .substring(0, 1) +
                      EnumToString.convertToString(widget.userData.type)
                          .substring(1)
                          .toLowerCase()
                          .replaceAll('_', '\n'),
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    color: Colors.purple[900],
                    fontFamily: 'Source Sans Pro',
                    fontSize: 15,
                  ),
                ),
                Text(
                  EnumToString.convertToString(widget.userData.status)
                          .substring(0, 1) +
                      EnumToString.convertToString(widget.userData.status)
                          .substring(1)
                          .toLowerCase()
                          .replaceAll('_', '\n'),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: CheckStatus(status: widget.userData.status)
                        .statusColor(),
                  ),
                ),
                CircleAvatar(
                  child: CheckType(type: widget.userData.type).typeIcon(),
                  radius: 15,
                  backgroundColor:
                      CheckStatus(status: widget.userData.status).statusColor(),
                  foregroundColor: Colors.white,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DetailRow(
                  keyString: 'Unavailable in',
                  valueString: CheckMethod(method: widget.userData.method)
                      .methodString(),
                ),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      'Leave',
                      style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontFamily: 'Source Sans Pro',
                        fontSize: 15,
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2.0, color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: Colors.white,
                    ),
                  ),
                  onTap: () async {
                    Leave data = await _leaveService
                        .getLeaveById(widget.userData.leaveId);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminLeaveDetailsPage(item: data),
                      ),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
