import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/services/user_service.dart';
import 'package:timecapturesystem/view/user_management/user_details.dart';

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

class UserCard extends StatefulWidget {
  final User user;

  const UserCard({
    Key key,
    this.user,
  });

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    var vIcon = widget.user.verified ? Icons.verified : Icons.cancel;
    var vIconColor = widget.user.verified ? Colors.green : Colors.redAccent;

    var imageURL = widget.user.profileImageURL == null
        ? 'default.png'
        : widget.user.profileImageURL;
    return GestureDetector(
      onDoubleTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserDetails(user: widget.user)),
        );
      },
      child: Container(
        height: 80,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(fileAPI + imageURL),
              ),
              Container(
                width: 150,
                child: Text(widget.user.fullName),
              ),
              Icon(
                vIcon,
                color: vIconColor,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

highestRoleName(int highestRoleIndex) {
  String role;

  switch (highestRoleIndex) {
    case 0:
      role = 'Team Member';
      break;
    case 1:
      role = 'Team Leader';
      break;
    case 2:
      role = 'Team Member';
      break;
    case 3:
      role = 'Team Member';
      break;
  }
}

//
// CircleAvatar(
// radius: 30.0,
// backgroundImage: NetworkImage(fileAPI + user.profileImageURL),
// ),
