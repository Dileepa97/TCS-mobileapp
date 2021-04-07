import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/rounded_button.dart';

import 'package:timecapturesystem/view/side_nav/side_drawer.dart';
import 'package:timecapturesystem/view/notification/notification_screen.dart';
import 'package:timecapturesystem/view/task/product_list.dart';
import 'package:timecapturesystem/view/task/user_tasks/user_task_dashboard.dart';
import 'package:timecapturesystem/view/team/team_view.dart';
import 'package:timecapturesystem/view/user_management/user_management_dashboard_screen.dart';

import 'admin/title_management.dart';

///time capture system user home page
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
      ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 35,),
            Center(
              child: Image(
                image: AssetImage('images/logo.png'),
              ),
            ),
            SizedBox(height: 30,),
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
                InkWell(
                  onTap: () {
                    // Navigator.pop(context);
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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications_active_outlined,color: Colors.white,size: 40,),
                        SizedBox(height: 10,),
                        Text("Notification Center")
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Navigator.pop(context);
                    Navigator.pushNamed(context, '/userLeave');
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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]
                    ),
                    child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.directions_walk_outlined,color: Colors.white,size: 40,),
                            SizedBox(height: 10,),
                            Text("Leave Management")
                            ],
                          ),
                    ),
                ),
                InkWell(
                  onTap: () {
                    // Navigator.pop(context);
                    Navigator.pushNamed(context, UserManagementDashboard.id);
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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.supervised_user_circle_outlined,color: Colors.white,size: 40,),
                        SizedBox(height: 10,),
                        Text("User Management")
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context)=>TeamView()
                    ));
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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]
                    ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.people,color: Colors.white,size: 40,),
                          SizedBox(height: 10,),
                          Text("Team Management")
                        ],
                      ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]
                    ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.list_alt_outlined,color: Colors.white,size: 40,),
                          SizedBox(height: 10,),
                          Text("Title Management")
                        ],
                      ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context)=>TaskPanel()
                    ));
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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.settings_backup_restore,color: Colors.white,size: 40,),
                        SizedBox(height: 10,),
                        Text("Partial Tasks")
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context)=>TaskPanel()
                    ));
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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.business_center,color: Colors.white,size: 40,),
                        SizedBox(height: 10,),
                        Text("Product Dashboard")
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context)=>UserTaskDashboard("184180F")
                    ));
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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.widgets,color: Colors.white,size: 40,),
                        SizedBox(height: 10,),
                        Text("Task Details")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
