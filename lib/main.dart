import 'package:flutter/material.dart';
import 'package:timecapturesystem/services/leaveService.dart';
import 'package:timecapturesystem/view/Auth/welcome_screen.dart';
import 'package:timecapturesystem/view/LMS/user/allLeaves.dart';
import 'package:timecapturesystem/view/LMS/user/ownLeave.dart';
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
          WelcomeScreen.id: (context) => WelcomeScreen(),
          //build welcome screen
          LoginScreen.id: (context) => LoginScreen(),
          // build the Login widget.
          RegistrationScreen.id: (context) => RegistrationScreen(),
          // build the Register widget.
          '/userLeave': (context) => UserLeave(),
          //  build the UserLeave widget.
          '/leaveRequest': (context) => LeaveRequest(),
          //  build the LeaveRequest widget.
          '/ownLeave': (context) => OwnLeave(),
          //  build the LeaveRequest widget.
          //'/allLeaves': (context) => AllLeave(),
          //  build the LeaveRequest widget.
        },
      ),
    );
