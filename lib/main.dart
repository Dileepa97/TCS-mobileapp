import 'package:flutter/material.dart';
import 'view/Auth/login_screen.dart';
import 'view/Auth/registration_screen.dart';
import 'view/LMS/user/userLeave.dart';
import 'view/LMS/user/leaveRequest.dart';
import 'view/homePage.dart';

void main() => runApp(
      MaterialApp(
        title: 'routes',
        initialRoute: '/', // Start the app with the "/" named route.
        routes: {
          '/': (context) => HomePage(),
          // build the HomePage widget.
          '/login': (context) => LoginScreen(),
          // build the Login widget.
          '/register': (context) => RegistrationScreen(),
          // build the Register widget.
          '/userLeave': (context) => UserLeave(),
          //  build the UserLeave widget.
          '/leaveRequest': (context) => LeaveRequest(),
          //  build the LeaveRequest widget.
        },
      ),
    );
