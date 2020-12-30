import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timecapturesystem/services/storage_service.dart';
import 'package:timecapturesystem/view/admin/title_change_management.dart';
import 'package:timecapturesystem/view/admin/title_management.dart';
import 'package:timecapturesystem/view/auth/change_password_screen.dart';
import 'package:timecapturesystem/view/auth/forgot_password_change.dart';
import 'package:timecapturesystem/view/auth/forgot_password_screen.dart';
import 'package:timecapturesystem/view/lms/admin_leave/get_all_leaves_screen.dart';
import 'package:timecapturesystem/view/lms/admin_leave/get_requested_leaves_screen.dart';
import 'package:timecapturesystem/view/lms/user_leave/leave_request_first_screen.dart';
import 'package:timecapturesystem/view/lms/user_leave/leave_request_main_screen.dart';
import 'package:timecapturesystem/view/lms/user_leave/own_user_leave_screen.dart';
import 'package:timecapturesystem/view/lms/user_leave/userLeave.dart';
import 'package:timecapturesystem/view/lms/user_leave/user_leave_availability_details_screen.dart';
import 'package:timecapturesystem/view/user/edit_profile_screen.dart';
import 'package:timecapturesystem/view/user_management/user_management_dashboard_screen.dart';

import 'managers/orientation.dart';
import 'view/Auth/login_screen.dart';
import 'view/Auth/registration_screen.dart';
import 'view/homePage.dart';
import 'view/user/pick_image_screen.dart';
import 'view/user/profile_screen.dart';

void main() async {
  await DotEnv().load('.env');
  OrientationManager.portraitMode();
  var userData = await TokenStorageService.authDataOrEmpty;
  if (userData != null) {
    DateTime dateTime = userData.tokenExpirationDate;
    if (dateTime.isBefore(DateTime.now())) {
      await TokenStorageService.clearStorage();
      userData = null;
    }
  }
  runApp(MyApp(userData));
}

class MyApp extends StatefulWidget {
  final userData;
  MyApp(this.userData);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  get userData => widget.userData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: (TokenStorageService.authDataOrEmpty),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          var routes;
          var initialRoute;
          if (userData != null) {
            // TokenStorageService.clearStorage();
            //TODO: check if expired and resolve bug
            print("user exist");
            initialRoute = '/';
            routes = {
              '/': (context) => HomePage(),
              UserManagementDashboard.id: (context) =>
                  UserManagementDashboard(),
              LoginScreen.id: (context) => LoginScreen(),
              RegistrationScreen.id: (context) => RegistrationScreen(),
              Profile.id: (context) => Profile(),
              EditProfile.id: (context) => EditProfile(),
              ChangePasswordScreen.id: (context) => ChangePasswordScreen(),
              PickImageScreen.id: (context) => PickImageScreen(),
              TitleManagementScreen.id: (context) => TitleManagementScreen(),
              TitleChangeManagementScreen.id: (context) =>
                  TitleChangeManagementScreen(),
              ForgotPasswordScreen.id: (context) => ForgotPasswordScreen(),
              ForgotPasswordChangeScreen.id: (context) =>
                  ForgotPasswordChangeScreen(),
              '/userLeave': (context) => UserLeave(),
              '/leaveRequest': (context) => LeaveRequest(),
              //  build the LeaveRequest widget.
              '/ownLeave': (context) => OwnLeaves(),
              //  build the LeaveRequest widget.
              '/allLeaves': (context) => AllLeave(),
              //  build the LeaveRequest widget.
              // build the Register widget.
              '/requestFirstScreen': (context) => FirstRequestScreen(),
              '/allRequestedLeaves': (context) => AllRequestedLeaves(),
              '/availableUserLeaves': (context) => UserLeaveAvailable(),
            };
          } else {
            print("user not exist");
            initialRoute = LoginScreen.id;

            routes = {
              '/': (context) => HomePage(),
              LoginScreen.id: (context) => LoginScreen(),
              ForgotPasswordScreen.id: (context) => ForgotPasswordScreen(),
              RegistrationScreen.id: (context) => RegistrationScreen(),
              ForgotPasswordChangeScreen.id: (context) =>
                  ForgotPasswordChangeScreen(),
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
