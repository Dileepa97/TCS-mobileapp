import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/components/leave_component/dashboard_button.dart';
import 'package:timecapturesystem/view/lms/user_leave/own_user_leave_screen.dart';

import 'leave_request/leave_request_first_screen.dart';

class UserLeaveDashboard extends StatefulWidget {
  static const String id = "user_leave_dashboard";

  @override
  _UserLeaveDashboardState createState() => _UserLeaveDashboardState();
}

class _UserLeaveDashboardState extends State<UserLeaveDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,

      ///App_bar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue.shade800,
        actions: [
          HomeButton(),
        ],
      ),

      ///Body
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Dashboard image
            Container(
              height: 150.0,
              width: 250.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/leave.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /// Dashboard title
                  Text(
                    "User Leave Dashboard",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  ///leave request button
                  LeaveDashBoardButton(
                    icon: Icons.view_list_outlined,
                    title: 'Request Leave',
                    route: FirstRequestScreen.id,
                    isIcon: true,
                  ),

                  ///my leaves button
                  LeaveDashBoardButton(
                    icon: Icons.view_list_outlined,
                    title: 'My Leaves',
                    route: OwnUserLeaves.id,
                    isIcon: true,
                  ),

                  ///all leaves button
                  LeaveDashBoardButton(
                    icon: Icons.view_list_outlined,
                    title: 'My Leave Availability',
                    route: '/availableUserLeaves',
                    isIcon: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
