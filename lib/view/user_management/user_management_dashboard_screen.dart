import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timecapturesystem/managers/orientation.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/services/user_service.dart';
import 'package:timecapturesystem/view/user_management/user_card.dart';

var apiEndpoint = DotEnv().env['API_URL'].toString();
var fileAPI = apiEndpoint + 'files/';

class UserManagementDashboard extends StatefulWidget {
  static const String id = "user_management_screen";

  @override
  _UserManagementDashboardState createState() =>
      _UserManagementDashboardState();
}

class _UserManagementDashboardState extends State<UserManagementDashboard> {
  @override
  Widget build(BuildContext context) {
    OrientationManager.enableRotation();
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,
      body: SafeArea(
        child: FutureBuilder<List<User>>(
          future: UserService.getAllUsers(context),
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            var child;
            if (snapshot.hasData) {
              var users = <Widget>[];
              snapshot.data.forEach((user) {
                users.add(UserCard(user: user));
              });

              child = ListView(
                children: users,
              );
            } else if (snapshot.hasError) {
              child = Column(children: <Widget>[
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ]);
            } else {
              child = Container(
                child: CircularProgressIndicator(),
              );
            }
            return Center(child: child);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    OrientationManager.portraitMode();
    super.dispose();
  }
}
