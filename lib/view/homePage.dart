import 'package:flutter/material.dart';

import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/services/other/storage_service.dart';
import 'package:timecapturesystem/view/customer/customer_dashboard_screen.dart';
import 'package:timecapturesystem/view/lms/admin_leave/admin_leave_dashboard_screen.dart';
import 'package:timecapturesystem/view/lms/user_leave/user_leave_dashboard_screen.dart';
import 'package:timecapturesystem/view/product/product_managemnet_dashboard_screen.dart';

import 'package:timecapturesystem/view/side_nav/side_drawer.dart';
import 'package:timecapturesystem/view/notification/notification_screen.dart';
import 'package:timecapturesystem/view/task/product_list.dart';
import 'package:timecapturesystem/view/task/reassign_task/reassign_task_to_team_members.dart';
import 'package:timecapturesystem/view/task/user_tasks/user_task_dashboard.dart';
import 'package:timecapturesystem/view/team/team_view.dart';
import 'package:timecapturesystem/view/user_management/user_management_dashboard_screen.dart';

import 'admin/title_management.dart';

///time capture system user home page
class HomePage extends StatefulWidget {
  static const String id = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User user;
  bool _userAvailable = false;

  ///get logged in user
  void getUser() async {
    user = await TokenStorageService.userDataOrEmpty;
    setState(() {
      _userAvailable = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        ///app bar
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black87,
          ),
        ),

        ///drawer
        drawer: SideDrawer(),
//      body: SafeArea(
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.stretch,
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: [
//
//            SingleChildScrollView(
//              child: Container(
//                child: GridView.count(
//                    crossAxisCount: 2,
//
//                  children: [
//                    Container(
//                      child: Text("User"),
//                    ),
//                    Container(
//                      child: Text("Leave"),
//                    ),
//                    Container(
//                      child: Text("Team"),
//                    ),
//                    Container(
//                      child: Text("Profile"),
//                    ),
//                  ],
//                ),
//              ),
//            ),
//             RoundedButton(
//               color: Colors.blueAccent,
//               onPressed: () {
//                 Navigator.pushNamed(context, '/userLeave');
//               },
//               title: 'Leave Management System',
//             ),
//             RoundedButton(
//               color: Colors.blue,
//               onPressed: () {
//                 Navigator.pushNamed(context, Profile.id);
//               },
//               title: 'Profile',
//             ),
//             RoundedButton(
//               color: Colors.blue,
//               onPressed: () {
//                 Navigator.pushNamed(context, UserManagementDashboard.id);
//               },
//               title: 'User Management',
//             ),
//             RoundedButton(
//               color: Colors.redAccent,
//               onPressed: () async {
//                 await AuthService.logout();
//                 Navigator.pushReplacementNamed(context, LoginScreen.id);
//               },
//               title: 'Logout',
//             ),
//             RoundedButton(
//               color: Colors.green,
//               onPressed: () async {
//                 Navigator.pushNamed(context, NotificationCenter.id);
//               },
//               title: 'Notification Center',
//             ),
//          ],
//        ),
//      ),
//
//
        ///body
        body: SingleChildScrollView(
          child: Column(
            children: [
              ///company logo
              SizedBox(
                height: 35,
              ),
              Center(
                child: Image(
                  image: AssetImage('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 30,
              ),

              ///grid view for button
              GridView.count(
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(10),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                // Generate 100 widgets that display their index in the List.
                children: [
                  ///Notification center - all users
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, NotificationCenter.id);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue.shade700,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications_active_outlined,
                            color: Colors.white,
                            size: 40,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Notification Center",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: 'Arial',
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  ///User management - super admin, admin
                  if (_userAvailable && user.highestRoleIndex > 1)
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, UserManagementDashboard.id);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue.shade700,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.supervised_user_circle_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("User Management",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: 'Arial',
                            ),)
                          ],
                        ),
                      ),
                    ),

                  ///leave management system - admin, teamleader, team member
                  if (_userAvailable && user.highestRoleIndex < 3)
                    InkWell(
                      onTap: () {
                        if (_userAvailable) {
                          if (user.highestRoleIndex == 2) {
                            Navigator.pushNamed(
                                context, AdminLeaveDashBoard.id);
                          } else if (user.highestRoleIndex < 2) {
                            Navigator.pushNamed(context, UserLeaveDashboard.id);
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue.shade700,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.directions_walk_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Leave Management System",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontFamily: 'Arial',
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                  ///customer management - admin
                  if (_userAvailable && user.highestRoleIndex == 2)
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, CustomerDashboard.id);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue.shade700,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.business_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Customer Management",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: 'Arial',
                            ),)
                          ],
                        ),
                      ),
                    ),

                  ///product management - admin
                  if (_userAvailable && user.highestRoleIndex == 2)
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, ProductManagementDashboard.id);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue.shade700,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.outbox,
                              color: Colors.white,
                              size: 40,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Product Management",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: 'Arial',
                            ),)
                          ],
                        ),
                      ),
                    ),

                  ///Task management - admin
                  if (_userAvailable && user.highestRoleIndex == 2)
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    TaskPanel()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue.shade700,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.business_center,
                              color: Colors.white,
                              size: 40,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Task Management",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: 'Arial',
                            ),)
                          ],
                        ),
                      ),
                    ),

                  ///Partial Tasks - team leader
                  if (_userAvailable && user.highestRoleIndex == 1)
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ReassignTasksToTeamMembers()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue.shade700,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.settings_backup_restore,
                              color: Colors.white,
                              size: 40,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Partial Tasks",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: 'Arial',
                            ),)
                          ],
                        ),
                      ),
                    ),

                  ///Task details - team leader, team member
                  if (_userAvailable && user.highestRoleIndex < 2)
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    UserTaskDashboard("184180F")));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue.shade700,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.widgets,
                              color: Colors.white,
                              size: 40,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Task Details",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: 'Arial',
                            ),)
                          ],
                        ),
                      ),
                    ),

                  ///Team management - admin, team leader
                  if (_userAvailable &&
                      (user.highestRoleIndex == 1))
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => TeamView()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue.shade700,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.people,
                              color: Colors.white,
                              size: 40,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("My Team",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: 'Arial',
                            ),)
                          ],
                        ),
                      ),
                    ),

                  ///title management - super admin , admin
                  if (_userAvailable && user.highestRoleIndex > 1)
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, TitleManagementScreen.id);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue.shade700,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.list_alt_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Title Management",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: 'Arial',
                            ),)
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
