import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/dialog_box.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/services/admin_service.dart';
import 'package:timecapturesystem/services/user_service.dart';
import 'package:timecapturesystem/view/user_management/user_management_dashboard.dart';

const fileAPI = 'http://localhost:8080/api/files/';
// const fileAPI = 'http://192.168.8.100:8080/api/files/';

class UserDetails extends StatefulWidget {
  static const String id = "user_details_screen";

  final User user;

  const UserDetails({
    Key key,
    @required this.user,
  });

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    var user = widget.user;

    var vIcon = user.verified ? Icons.verified : Icons.cancel;
    var vIconColor = user.verified ? Colors.greenAccent : Colors.redAccent;
    var imageURL = ((user.profileImageURL == null)
        ? ('default.png')
        : (user.profileImageURL));

    var isAdmin = false;
    var isTeamLead = false;

    for (dynamic role in user.roles) {
      if (role.name == "ROLE_TEAM_MEMBER") {}

      if (role.name == "ROLE_TEAM_LEADER") {
        isTeamLead = true;
      }

      if (role.name == "ROLE_ADMIN") {
        isAdmin = true;
      }
      if (role.name == "ROLE_SUPER_ADMIN") {}
    }

    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              user.fullName,
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 40.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            CircleAvatar(
              radius: 90.0,
              backgroundImage: NetworkImage('$fileAPI$imageURL'),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              user.username,
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Colors.black87,
                fontSize: 20.0,
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      user.title == null ? '' : user.title,
                      style: TextStyle(
                        fontFamily: 'Source Sans Pro',
                        color: Colors.white70,
                        fontSize: 20.0,
                        letterSpacing: 2.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
              width: 150.0,
              child: Divider(
                color: Colors.lightBlueAccent.shade100,
              ),
            ),
            Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.green.shade900,
                  ),
                  title: Text(
                    user.telephoneNumber,
                    style: TextStyle(
                      color: Colors.blueGrey.shade900,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20.0,
                    ),
                  ),
                )),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.email,
                  color: Colors.blue.shade900,
                ),
                title: Text(
                  user.email,
                  style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.blueGrey.shade900,
                      fontFamily: 'Source Sans Pro'),
                ),
              ),
            ),

            //TODO:icons for delete verify un-verify assign roles
            Container(
                margin: EdgeInsets.all(15),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.admin_panel_settings,
                            color: isAdmin ? Colors.white : Colors.black87,
                            size: 35.0,
                          ),
                          onPressed: () async {
                            if (isAdmin) {
                              var confirmed =
                                  await displayDowngradeAdminSureDialog(
                                      context);
                              if (confirmed == null ? false : confirmed) {}
                            } else {
                              var confirmed =
                                  await displayUpliftToAdminSureDialog(context);
                              if (confirmed == null ? false : confirmed) {}
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.accessibility_new,
                            color: isTeamLead ? Colors.white : Colors.black87,
                            size: 35.0,
                          ),
                          onPressed: () async {
                            if (isTeamLead) {
                              var confirmed =
                                  await displayDowngradeTeamLeadSureDialog(
                                      context);
                              if (confirmed == null ? false : confirmed) {}
                            } else {
                              var confirmed =
                                  await displayUpliftToTeamLeadSureDialog(
                                      context);
                              if (confirmed == null ? false : confirmed) {}
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete_forever,
                            color:
                                user.verified ? Colors.black87 : Colors.white,
                            size: 35.0,
                          ),
                          onPressed: () async {
                            if (user.verified) {
                              displayDialog(context, "Invalid Operation",
                                  "Only un-verified users can be deleted");
                            } else {
                              var confirmed =
                                  await displayDeleteUserSureDialog(context);

                              if (confirmed == null ? false : confirmed) {}
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            vIcon,
                            color: vIconColor,
                            size: 35.0,
                          ),
                          onPressed: () async {
                            var confirmed = await handleVerifySureDialog(
                                context, user.verified);

                            if (confirmed == null ? false : confirmed) {
                              bool success =
                                  await AdminService.handleUserVerification(
                                      user.id, user.verified);

                              if (success) {
                                var user = await UserService.getUserById(
                                    widget.user.id);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, UserManagementDashboard.id);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UserDetails(user: user)));
                              } else {
                                operationFailed(context);
                              }
                            }
                          },
                        ),
                      ],
                    )
                  ],
                )),
          ],
        ),
      )),
    );
  }
}
