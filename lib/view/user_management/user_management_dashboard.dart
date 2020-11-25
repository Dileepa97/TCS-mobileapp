import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/services/user_service.dart';

const fileAPI = 'http://localhost:8080/api/files/';

class UserManagementDashboard extends StatefulWidget {
  static const String id = "user_management_screen";

  @override
  _UserManagementDashboardState createState() =>
      _UserManagementDashboardState();
}

class _UserManagementDashboardState extends State<UserManagementDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,
      body: SafeArea(
        child: FutureBuilder<List<User>>(
          future: UserService().getAllUsers(context),
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              var users = <Widget>[];
              snapshot.data.forEach((user) {
                users.add(UserCard(user: user));
              });

              children = users;
            } else if (snapshot.hasError) {
              children = <Widget>[
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ];
            } else {
              children = <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('loading'),
                )
              ];
            }
            return Center(
              child: ListView(
                children: children,
              ),
            );
          },
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({
    Key key,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    var vIcon = user.verified ? Icons.verified : Icons.cancel;
    var vIconColor = user.verified ? Colors.lightGreenAccent : Colors.redAccent;

    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.ac_unit),
              title: Text(user.fullName),
              subtitle: Text(user.username),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('View'),
                  onPressed: () {
                    /* ... */
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//
// CircleAvatar(
// radius: 30.0,
// backgroundImage: NetworkImage(fileAPI + user.profileImageURL),
// ),
