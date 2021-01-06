import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/lms/leave.dart';
import 'package:timecapturesystem/models/lms/leave_response.dart';
import 'package:timecapturesystem/view/lms/admin_leave/admin_leave_card.dart';
import 'package:timecapturesystem/view/lms/admin_leave/admin_leave_detail_screen.dart';
import 'package:timecapturesystem/view/lms/user_leave/user_leave_card.dart';
import 'package:timecapturesystem/view/lms/user_leave/user_leave_details_page.dart';

class LeaveListViewBuilder extends StatelessWidget {
  final List<Leave> list;
  final bool isUserLeave;

  const LeaveListViewBuilder({Key key, this.list, this.isUserLeave})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(list);
    // print(isUserLeave);
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          // child: isUserLeave
          //     ? UserLeaveCard(item: list[index])
          //     : LeaveCard(item: list[index]),
          child: AdminLeaveCard(item: list[index]),
          onTap: () {
            if (isUserLeave) {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => UserLeaveDetailsPage(item: list[index]),
              //   ),
              // );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LeaveDetailsPage(item: list[index]),
                ),
              );
            }
          },
        );
      },
    );
  }
}
