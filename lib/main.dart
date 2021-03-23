import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timecapturesystem/services/other/storage_service.dart';
import 'package:timecapturesystem/view/admin/title_change_management.dart';
import 'package:timecapturesystem/view/admin/title_management.dart';
import 'package:timecapturesystem/view/auth/change_password_screen.dart';
import 'package:timecapturesystem/view/auth/forgot_password_change.dart';
import 'package:timecapturesystem/view/auth/forgot_password_screen.dart';
import 'package:timecapturesystem/view/lms/admin_leave/admin_leave_dashboard.dart';
import 'package:timecapturesystem/view/lms/admin_leave/admin_leave_detail_screen.dart';
import 'package:timecapturesystem/view/lms/admin_leave/get_all_leaves_screen.dart';
import 'package:timecapturesystem/view/lms/admin_leave/get_requested_leaves_screen.dart';
import 'package:timecapturesystem/view/lms/admin_leave/leave_by_month.dart';
import 'package:timecapturesystem/view/lms/admin_leave/today_unavailable_users.dart';
import 'package:timecapturesystem/view/lms/user_leave/leave_request_first_screen.dart';
import 'package:timecapturesystem/view/lms/user_leave/leave_request_main_screen.dart';
import 'package:timecapturesystem/view/lms/user_leave/own_user_leave_screen.dart';
import 'package:timecapturesystem/view/lms/user_leave/userLeave.dart';
import 'package:timecapturesystem/view/lms/user_leave/user_leave_availability_details_screen.dart';
import 'package:timecapturesystem/view/lms/user_leave/user_leave_dashboard.dart';
import 'package:timecapturesystem/view/notification/notification_screen.dart';
import 'package:timecapturesystem/view/user/edit_profile_screen.dart';
import 'package:timecapturesystem/view/user_management/user_management_dashboard_screen.dart';

import 'managers/orientation.dart';
import 'view/Auth/login_screen.dart';
import 'view/Auth/registration_screen.dart';
import 'view/homePage.dart';
import 'view/lms/admin_leave/get_leaves_screen.dart';
import 'view/lms/admin_leave/week_unavailable_users.dart';
import 'view/user/pick_image_screen.dart';
import 'view/user/profile_screen.dart';

void main() async {
  await DotEnv().load('.env');
  OrientationManager.portraitMode();
  var userData = await TokenStorageService.authDataOrEmpty;
  var username = await storage.read(key: "username");
  if (userData != null) {
    DateTime dateTime = userData.tokenExpirationDate;
    if (dateTime.isBefore(DateTime.now())) {
      await TokenStorageService.clearStorage();
      userData = null;
    }
  }
  runApp(MyApp(userData, username));
}

class MyApp extends StatefulWidget {
  final userData;
  final username;

  MyApp(this.userData, this.username);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  get userData => widget.userData;

  get username => widget.username;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: (TokenStorageService.authDataOrEmpty),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          var routes;
          var initialRoute;
          if (userData != null) {
            //TODO: check if expired and resolve bug
            initialRoute = '/';
            routes = {
              //add routes that user can access only after logging
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
              NotificationCenter.id: (context) => NotificationCenter(),
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
              '/adminLeaveDashboard': (context) => AdminLeaveDashBoard(),
              '/adminGetLeaves': (context) => AdminGetLeaves(),
              '/adminLeaveByMonth': (context) => AdminLeaveByMonth(),
              '/userLeaveDashboard': (context) => UserLeaveDashboard(),
              '/todayUnavailableUserScreen': (context) =>
                  TodayUnavailableUserScreen(),
              '/weekUnavailableUserScreen': (context) =>
                  WeekUnavailableUserScreen(),
              '/adminLeaveDetailsPage': (context) => LeaveDetailsPage(),
            };
          } else {
            initialRoute = LoginScreen.id;
            //add routes that user can access without login
            routes = {
              '/': (context) => HomePage(),
              LoginScreen.id: (context) => LoginScreen(
                    username: username,
                  ),
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
