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
  User user;
  bool _userAvailable = false;

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
    if (_userAvailable) print(user.fullName);
    User _user;
    String unseenCount = '0';
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<dynamic>(
            future: UserService.getLoggedInUserAndNotificationCount(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              Widget _emailWidget;
              Widget _nameWidget;
              Widget _avatar;

              if (snapshot.hasData) {
                _user = snapshot.data[0];
                unseenCount = snapshot.data[1];

                _emailWidget = Text(
                  _user.email,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                );
                _nameWidget = Text(
                  _user.username,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                );
                _avatar = CircleAvatar(
                  backgroundImage: _user.profileImageURL == 'default.png'
                      ? AssetImage('images/default.png')
                      : NetworkImage(fileAPI + _user.profileImageURL),
                  backgroundColor: Colors.white,
                );
              } else if (snapshot.hasError) {
                _emailWidget = null;
                _nameWidget = null;
                _avatar = CircleAvatar(
                  backgroundColor: Colors.white,
                );
              } else {
                _emailWidget = null;
                _nameWidget = null;
                _avatar = CircleAvatar(
                  backgroundColor: Colors.white,
                );
              }

              return ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountEmail: _emailWidget,
                    accountName: _nameWidget,
                    currentAccountPicture: GestureDetector(
                      child: _avatar,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, Profile.id);
                      },
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
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
                  ListTile(
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
                        if (user.highestRoleIndex == 2) {
                          Navigator.pushNamed(context, AdminLeaveDashBoard.id);
                        } else if (user.highestRoleIndex < 2) {
                          Navigator.pushNamed(context, UserLeaveDashboard.id);
                        }
                      }
                    },
                  ),
                  ListTile(
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
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => TeamView()));
                    },
                  ),
                  ListTile(
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
                      Navigator.pushNamed(context, UserManagementDashboard.id);
                    },
                  ),
                  ListTile(
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
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.work),
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
                  ),
                  ListTile(
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
                      Navigator.pushNamed(context, TitleManagementScreen.id);
                    },
                  ),
                  DividerBox(),
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
                      Navigator.pushReplacementNamed(context, LoginScreen.id);
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
