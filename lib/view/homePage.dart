import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/rounded_button.dart';
import 'package:timecapturesystem/services/AuthService.dart';
import 'package:timecapturesystem/view/auth/login_screen.dart';
import 'package:timecapturesystem/view/user/Profile.dart';

import 'package:timecapturesystem/main.dart' as app;
import 'Auth/auth_screen.dart';

///time capture system user home page
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedButton(
            color: Colors.blueAccent,
            onPressed: () {
              Navigator.pushNamed(context, '/userLeave');
            },
            title: 'Leave Management System',
          ),
          RoundedButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.pushNamed(context, Profile.id);
            },
            title: 'Profile',
          ),
          RoundedButton(
            color: Colors.redAccent,
            onPressed: () async {
              app.main();
              await AuthService.logout();
              Navigator.pushReplacementNamed(context, LoginScreen.id);
            },
            title: 'Logout',
          ),
        ],
      ),
    );
  }
}
