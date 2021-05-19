import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/leave_component/alert_dialogs.dart';
import 'package:timecapturesystem/components/leave_component/detail_row.dart';
import 'package:timecapturesystem/models/lms/absent_user_data.dart';
import 'package:timecapturesystem/services/lms/leave_service.dart';
import 'package:timecapturesystem/components/leave_component/leave_user_data_builders.dart';
import 'package:timecapturesystem/view/lms/admin_leave/admin_leave_detail_page.dart';
import 'package:timecapturesystem/view/lms/check_leaves.dart';

import 'package:timecapturesystem/view/lms/team_leader_leave/TL_leave_detail_screen.dart';
import 'package:timecapturesystem/view/widgets/loading_screen.dart';

class AbsentUserCard extends StatefulWidget {
  final AbsentUser userData;
  final bool isTeam;

  const AbsentUserCard({Key key, this.userData, this.isTeam}) : super(key: key);

  @override
  _AbsentUserCardState createState() => _AbsentUserCardState();
}

class _AbsentUserCardState extends State<AbsentUserCard> {
  LeaveService _leaveService = LeaveService();
  ShowAlertDialog _dialog = ShowAlertDialog();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      height: 150,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          ///Row1
          Row(
            children: [
              ///profile image
              UserProfileImage(
                  userId: widget.userData.userId, height: 35, width: 35),

              ///user name
              UserNameText(
                userId: widget.userData.userId,
                fontSize: 16,
              )
            ],
          ),

          ///Row2
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///leave type
                Text(
                  EnumToString.convertToString(widget.userData.type)
                          .substring(0, 1) +
                      EnumToString.convertToString(widget.userData.type)
                          .substring(1)
                          .toLowerCase()
                          .replaceAll('_', '\n'),
                  style: TextStyle(
                    color: Colors.purple[900],
                    fontFamily: 'Source Sans Pro',
                    fontSize: 16,
                  ),
                ),

                ///leave status
                Text(
                  EnumToString.convertToString(widget.userData.status)
                          .substring(0, 1) +
                      EnumToString.convertToString(widget.userData.status)
                          .substring(1)
                          .toLowerCase()
                          .replaceFirst('_', '\n')
                          .replaceAll('_', ' '),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: CheckStatus(status: widget.userData.status)
                        .statusColor(),
                  ),
                ),

                ///type & status icon
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

          ///Row3
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///unavailable time
                DetailRow(
                  keyString: 'Unavailable in ',
                  valueString: CheckMethod.methodString(widget.userData.method),
                ),

                ///buuton to leave detail page
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 3),
                    child: Text(
                      'Leave',
                      style: TextStyle(
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
                    Navigator.pushNamed(context, LoadingScreen.id);

                    dynamic data = await _leaveService
                        .getLeaveById(widget.userData.leaveId);

                    if (this.mounted) {
                      Navigator.pop(context);

                      if (data == 204 || data == 1 || data == -1) {
                        this._dialog.showAlertDialog(
                              context: context,
                              title: 'Error occured',
                              body: 'Cannot fetch this leave data',
                              color: Colors.redAccent,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            );
                      } else {
                        widget.isTeam
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TLLeaveDetailsPage(item: data),
                                ),
                              )
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdminLeaveDetailsPage(
                                    item: data,
                                    isMoreUserLeave: false,
                                    isOngoing: false,
                                  ),
                                ),
                              );
                      }
                    }
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
