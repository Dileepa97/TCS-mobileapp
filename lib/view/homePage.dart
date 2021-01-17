import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/rounded_button.dart';

import 'package:timecapturesystem/view/side_nav/side_drawer.dart';
import 'package:timecapturesystem/view/user/notification_screen.dart';

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
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
      ),
      drawer: SideDrawer(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // RoundedButton(
            //   color: Colors.blueAccent,
            //   onPressed: () {
            //     Navigator.pushNamed(context, '/userLeave');
            //   },
            //   title: 'Leave Management System',
            // ),
            // RoundedButton(
            //   color: Colors.blue,
            //   onPressed: () {
            //     Navigator.pushNamed(context, Profile.id);
            //   },
            //   title: 'Profile',
            // ),
            // RoundedButton(
            //   color: Colors.blue,
            //   onPressed: () {
            //     Navigator.pushNamed(context, UserManagementDashboard.id);
            //   },
            //   title: 'User Management',
            // ),
            // RoundedButton(
            //   color: Colors.redAccent,
            //   onPressed: () async {
            //     await AuthService.logout();
            //     Navigator.pushReplacementNamed(context, LoginScreen.id);
            //   },
            //   title: 'Logout',
            // ),
            RoundedButton(
              color: Colors.green,
              onPressed: () async {
                Navigator.pushNamed(context, NotificationCenter.id);
              },
              title: 'Notification Center',
            ),
            Center(
              child: Image(
                image: AssetImage('images/logo.png'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
