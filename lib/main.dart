import 'package:flutter/material.dart';
import 'package:timecapturesytem/view/Auth/auth.dart';
import 'view/LMS/user/userLeave.dart';
import 'view/LMS/user/leaveRequest.dart';
import 'view/homePage.dart';

void main() => runApp(MaterialApp(
      title: 'routes',

      initialRoute: '/', // Start the app with the "/" named route.
      routes: {
        '/': (context) => HomePage(), // build the HomePage widget.
        '/auth': (context) => AuthScreen(), // build the HomePage widget.
        '/userLeave': (context) => UserLeave(), //  build the UserLeave widget.
        '/leaveRequest': (context) =>
            LeaveRequest(), //  build the LeaveRequest widget.
      },
    ));
