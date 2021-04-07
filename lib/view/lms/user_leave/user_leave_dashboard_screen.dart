import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/components/leave_component/dashboard_button.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/services/other/storage_service.dart';
import 'package:timecapturesystem/view/lms/team_leader/TL_today_unavailable_user_screen.dart';
import 'package:timecapturesystem/view/lms/team_leader/TL_week_unavailable_users_screen.dart';
import 'package:timecapturesystem/view/lms/user_leave/own_user_leave_screen.dart';
import 'package:timecapturesystem/view/lms/user_leave/user_leave_availability_details_screen.dart';

import 'leave_request/leave_request_first_screen.dart';

class UserLeaveDashboard extends StatefulWidget {
  static const String id = "user_leave_dashboard";

  @override
  _UserLeaveDashboardState createState() => _UserLeaveDashboardState();
}

class _UserLeaveDashboardState extends State<UserLeaveDashboard> {
  User _user;
  bool _userAvailable = false;
  bool _teamLeader = false;
  String _teamId;

  ///get looged-in user data
  void _getUser() async {
    _user = await TokenStorageService.userDataOrEmpty;

    setState(() {
      _userAvailable = true;
    });
    if (_userAvailable) {
      if (_user.highestRoleIndex == 1) {
        setState(() {
          _teamLeader = true;
          _teamId = _user.teamId;
        });
      } else if (_user.highestRoleIndex < 1) {
        setState(() {
          _teamLeader = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

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
      body: SafeArea(
        child: SingleChildScrollView(
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
                    _teamLeader
                        ? Text(
                            "Team Leader Leave Dashboard",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          )
                        : Text(
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

                    _teamLeader
                        ? Row(
                            children: [
                              ///Today absent button
                              Expanded(
                                child: DashBoardButton(
                                  height: 50.0,
                                  title: 'Today absent',
                                  route: TLTodayUnavailableUserScreen.id,
                                ),
                              ),

                              /// week absent button
                              Expanded(
                                child: DashBoardButton(
                                  height: 50.0,
                                  title: 'Week absent',
                                  route: TLWeekUnavailableUserScreen.id,
                                ),
                              ),
                            ],
                          )
                        : SizedBox(),

                    ///leave request button
                    DashBoardButton(
                      icon: Icons.view_list_outlined,
                      title: 'Request Leave',
                      route: FirstRequestScreen.id,
                      isIcon: true,
                    ),

                    ///my leaves button
                    DashBoardButton(
                      icon: Icons.view_list_outlined,
                      title: 'My Leaves',
                      route: OwnUserLeaves.id,
                      isIcon: true,
                    ),

                    /// leave availabilty button
                    DashBoardButton(
                      icon: Icons.view_list_outlined,
                      title: 'My Leave Availability',
                      route: UserLeaveAvailable.id,
                      isIcon: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
