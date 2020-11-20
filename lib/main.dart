import 'package:flutter/material.dart';
import 'package:timecapturesystem/services/StorageService.dart';
import 'package:timecapturesystem/view/LMS/admin/getLeaves.dart';
import 'package:timecapturesystem/view/LMS/user/ownLeave.dart';
import 'package:timecapturesystem/view/user/EditProfile.dart';

import 'view/user/Profile.dart';
import 'view/Auth/login_screen.dart';
import 'view/Auth/registration_screen.dart';
import 'view/LMS/user/userLeave.dart';
import 'view/LMS/user/leaveRequest.dart';
import 'view/homePage.dart';

void main() async => {runApp(MyApp())};

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: TokenStorageService.authDataOrEmpty,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          var routes;
          var initialRoute;
          if (snapshot.hasData) {
            // TokenStorageService.clearStorage();
            //TODO: check if expired and resolve bug
            print("user exist");
            initialRoute = '/';
            routes = {
              '/': (context) => HomePage(),
              // build the HomePage widget.

              LoginScreen.id: (context) => LoginScreen(),
              // build the Login widget.
              RegistrationScreen.id: (context) => RegistrationScreen(),

              Profile.id: (context) => Profile(),
              EditProfile.id: (context) => EditProfile(),

              '/userLeave': (context) => UserLeave(),
              //  build the UserLeave widget.
              '/leaveRequest': (context) => LeaveRequest(),
              //  build the LeaveRequest widget.
              '/ownLeave': (context) => OwnLeave(),
              //  build the LeaveRequest widget.
              '/allLeaves': (context) => AllLeave(),
              //  build the LeaveRequest widget.
              // build the Register widget.
            };
          } else {
            print("user not exist");
            initialRoute = LoginScreen.id;

            routes = {
              '/': (context) => HomePage(),
              LoginScreen.id: (context) => LoginScreen(),
              // build the Login widget.
              RegistrationScreen.id: (context) => RegistrationScreen(),
              //  build the LeaveRequest widget.
            };
          }

          return MaterialApp(
              title: 'routes',
              theme: ThemeData(
                scaffoldBackgroundColor: Color(0xFFF1F1F1),
              ),
              initialRoute:
                  initialRoute, // Start the app with the "/" named route.
              routes: routes);
        });
  }
}
