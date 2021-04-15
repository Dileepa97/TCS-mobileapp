import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/components/leave_component/dashboard_button.dart';
import 'package:timecapturesystem/view/lms/admin_leave/absent_users_screens/today_unavailable_users_screen.dart';
import 'package:timecapturesystem/view/lms/admin_leave/absent_users_screens/week_unavailable_users_screen.dart';
import 'package:timecapturesystem/view/lms/admin_leave/get_leaves_screens/admin_all_leaves_screen.dart';
import 'package:timecapturesystem/view/lms/admin_leave/get_leaves_screens/admin_leaves_by_status_screen.dart';
import 'package:timecapturesystem/view/lms/admin_leave/change_allowed_days_screen.dart';
import 'package:timecapturesystem/view/lms/admin_leave/ongoing_leave_cancellation_manager_screen.dart';
import 'package:timecapturesystem/view/widgets/loading_screen.dart';

//done
class AdminLeaveDashBoard extends StatefulWidget {
  static const String id = "admin_leave_dashboard";

  @override
  _AdminLeaveDashBoardState createState() => _AdminLeaveDashBoardState();
}

class _AdminLeaveDashBoardState extends State<AdminLeaveDashBoard> {
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// Dashboard title
                    Text(
                      "Admin Leave Dashboard",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Row(
                      children: [
                        ///Today absent button
                        Expanded(
                          child: DashBoardButton(
                            height: 50.0,
                            title: 'Today absent',
                            route: TodayUnavailableUserScreen.id,
                          ),
                        ),

                        /// week absent button
                        Expanded(
                          child: DashBoardButton(
                            height: 50.0,
                            title: 'Week absent',
                            route: WeekUnavailableUserScreen.id,
                          ),
                        ),
                      ],
                    ),

                    ///all leaves button
                    DashBoardButton(
                      icon: Icons.view_list_outlined,
                      title: 'All leaves',
                      route: AdminAllLeaves.id,
                      isIcon: true,
                    ),

                    ///leaves by status button
                    DashBoardButton(
                      icon: Icons.view_list_outlined,
                      title: 'Leaves by status',
                      route: AdminLeaveByStatus.id,
                      isIcon: true,
                    ),

                    ///leave cancellation manager button
                    DashBoardButton(
                      icon: Icons.view_list_outlined,
                      title: 'Ongoing leave cancellation manager',
                      route: OngoingLeaveCancellationManager.id,
                      isIcon: true,
                    ),

                    ///leave allocation manager button
                    DashBoardButton(
                      icon: Icons.view_list_outlined,
                      title: 'Leaves allocation manager',
                      route: ChangeAllowedDays.id,
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
