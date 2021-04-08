import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timecapturesystem/components/leave_component/divider_box.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/services/auth/auth_service.dart';
import 'package:timecapturesystem/services/other/storage_service.dart';
import 'package:timecapturesystem/services/user/user_service.dart';
import 'package:timecapturesystem/view/admin/title_management.dart';
import 'package:timecapturesystem/view/auth/login_screen.dart';
import 'package:timecapturesystem/view/customer/customer_dashboard_screen.dart';
import 'package:timecapturesystem/view/lms/admin_leave/admin_leave_dashboard_screen.dart';
import 'package:timecapturesystem/view/lms/user_leave/user_leave_dashboard_screen.dart';
import 'package:timecapturesystem/view/homePage.dart';
import 'package:timecapturesystem/view/notification/notification_screen.dart';
import 'package:timecapturesystem/view/product/product_managemnet_dashboard_screen.dart';
import 'package:timecapturesystem/view/task/product_list.dart';
import 'package:timecapturesystem/view/task/user_tasks/user_task_dashboard.dart';
import 'package:timecapturesystem/view/team/team_view.dart';
import 'package:timecapturesystem/view/user/profile_screen.dart';
import 'package:timecapturesystem/view/user_management/user_management_dashboard_screen.dart';

var apiEndpoint = DotEnv().env['API_URL'].toString();
var fileAPI = apiEndpoint + 'files/';

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  User _loggedUser;
  bool _userAvailable = false;

  ///get logged in user
  void getUser() async {
    _loggedUser = await TokenStorageService.userDataOrEmpty;
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
    if (_userAvailable) print(_loggedUser.fullName);
    String unseenCount = '0';
    User _fetchedUser;
    String _profileUrl = '';

    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<dynamic>(
            future: UserService.getLoggedInUserAndNotificationCount(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                _fetchedUser = snapshot.data[0];
                unseenCount = snapshot.data[1];

                _profileUrl = _fetchedUser.profileImageURL;
              } else if (snapshot.hasError) {
              } else {}

              return ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ///Drawer header
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),

                    ///Account email
                    accountEmail: _userAvailable
                        ? Text(
                            _loggedUser.email,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          )
                        : Text(
                            'email',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),

                    ///Account name
                    accountName: GestureDetector(
                      child: _userAvailable
                          ? Text(
                              _loggedUser.fullName.split(' ').length < 2
                                  ? _loggedUser.fullName.split(' ').elementAt(0)
                                  : _loggedUser.fullName
                                          .split(' ')
                                          .elementAt(0) +
                                      '  ' +
                                      _loggedUser.fullName
                                          .split(' ')
                                          .elementAt(1),
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            )
                          : Text(
                              'user name',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, Profile.id);
                      },
                    ),

                    ///Account picture
                    currentAccountPicture: GestureDetector(
                      child: _profileUrl != '' && _profileUrl != null
                          ? CircleAvatar(
                              backgroundImage: _profileUrl == 'default.png'
                                  ? AssetImage('images/default.png')
                                  : NetworkImage(fileAPI + _profileUrl),
                              backgroundColor: Colors.white,
                            )
                          : CircleAvatar(
                              backgroundImage: AssetImage('images/default.png'),
                              backgroundColor: Colors.white,
                            ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, Profile.id);
                      },
                    ),
                  ),

                  ///Drawer items
                  ///Notification center - all users
                  ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.notifications_active_outlined),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text('Notification Center'),
                        SizedBox(
                          width: 5.0,
                        ),
                        unseenCount != '0'
                            ? Container(
                                padding: EdgeInsets.all(2),
                                decoration: new BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 22,
                                  minHeight: 22,
                                ),
                                child: new Text(
                                  unseenCount,
                                  style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : Text('')
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, NotificationCenter.id);
                    },
                  ),

                  ///User management - super admin, admin
                  _userAvailable && _loggedUser.highestRoleIndex > 1
                      ? ListTile(
                          title: Row(
                            children: [
                              Icon(Icons.person),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('User Management'),
                            ],
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(
                                context, UserManagementDashboard.id);
                          },
                        )
                      : SizedBox(),

                  ///Leave management system -  admin, teamleader, team member
                  _userAvailable && _loggedUser.highestRoleIndex < 3
                      ? ListTile(
                          title: Row(
                            children: [
                              Icon(Icons.directions_walk_outlined),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('Leave Management System'),
                            ],
                          ),
                          onTap: () {
                            if (_userAvailable) {
                              Navigator.pop(context);
                              if (_loggedUser.highestRoleIndex == 2) {
                                Navigator.pushNamed(
                                    context, AdminLeaveDashBoard.id);
                              } else if (_loggedUser.highestRoleIndex < 2) {
                                Navigator.pushNamed(
                                    context, UserLeaveDashboard.id);
                              }
                            }
                          },
                        )
                      : SizedBox(),

                  ///customer management - admin
                  _userAvailable && _loggedUser.highestRoleIndex == 2
                      ? ListTile(
                          title: Row(
                            children: [
                              Icon(Icons.business_outlined),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('Customer Management'),
                            ],
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, CustomerDashboard.id);
                          },
                        )
                      : SizedBox(),

                  ///product management - admin
                  _userAvailable && _loggedUser.highestRoleIndex == 2
                      ? ListTile(
                          title: Row(
                            children: [
                              Icon(Icons.outbox),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('Product Management'),
                            ],
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(
                                context, ProductManagementDashboard.id);
                          },
                        )
                      : SizedBox(),

                  ///Task management - admin
                  _userAvailable && _loggedUser.highestRoleIndex == 2
                      ? ListTile(
                          title: Row(
                            children: [
                              Icon(Icons.business_center),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('Task Management'),
                            ],
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        TaskPanel()));
                          },
                        )
                      : SizedBox(),

                  ///Task details - team leader, team member
                  _userAvailable && _loggedUser.highestRoleIndex < 2
                      ? ListTile(
                          title: Row(
                            children: [
                              Icon(Icons.widgets),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('Task Details'),
                            ],
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        UserTaskDashboard("184180F")));
                          },
                        )
                      : SizedBox(),

                  ///Team management - admin, team leader
                  _userAvailable &&
                          (_loggedUser.highestRoleIndex == 2 ||
                              _loggedUser.highestRoleIndex == 1)
                      ? ListTile(
                          title: Row(
                            children: [
                              Icon(Icons.people),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('Team Management'),
                            ],
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        TeamView()));
                          },
                        )
                      : SizedBox(),

                  ///title management - super admin , admin
                  _userAvailable && _loggedUser.highestRoleIndex > 1
                      ? ListTile(
                          title: Row(
                            children: [
                              Icon(Icons.list_alt_outlined),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('Title Management'),
                            ],
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(
                                context, TitleManagementScreen.id);
                          },
                        )
                      : SizedBox(),
                  DividerBox(),

                  ///home - all user
                  ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.home),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text('Home'),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => HomePage()));
                    },
                  ),

                  ///log out - all user
                  ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.logout),
                        SizedBox(width: 6.0),
                        Text('Logout'),
                      ],
                    ),
                    onTap: () async {
                      await AuthService.logout();
                      Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id,
                          (Route<dynamic> route) => false);
                      ModalRoute.withName('/');
                    },
                  ),
                ],
              );
            }),
      ),
    );
  }
}
