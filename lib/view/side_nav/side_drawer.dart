import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timecapturesystem/components/leave_component/divider_box.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/services/auth_service.dart';
import 'package:timecapturesystem/services/user_service.dart';
import 'package:timecapturesystem/view/admin/title_management.dart';
import 'package:timecapturesystem/view/auth/login_screen.dart';
import 'package:timecapturesystem/view/notification/notification_screen.dart';
import 'package:timecapturesystem/view/user/profile_screen.dart';
import 'package:timecapturesystem/view/user_management/user_management_dashboard_screen.dart';

var apiEndpoint = DotEnv().env['API_URL'].toString();
var fileAPI = apiEndpoint + 'files/';

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<User>(
            future: UserService.getLoggedInUser(),
            builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
              Widget _emailWidget;
              Widget _nameWidget;
              Widget _avatar;

              if (snapshot.hasData) {
                User _user = snapshot.data;

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
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/userLeave');
                    },
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.supervised_user_circle_outlined),
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
