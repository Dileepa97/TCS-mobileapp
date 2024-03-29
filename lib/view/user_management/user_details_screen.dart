import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timecapturesystem/components/dialog_boxes.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/models/user/user_history.dart';
import 'package:timecapturesystem/services/admin/admin_service.dart';
import 'package:timecapturesystem/services/other/storage_service.dart';
import 'package:timecapturesystem/services/user/user_service.dart';
import 'package:timecapturesystem/view/lms/admin_leave/admin_user_leave_related_screens/admin_user_leave_detail_screen.dart';
import 'package:timecapturesystem/view/user_management/update_table_screen.dart';
import 'package:timecapturesystem/view/user_management/user_management_dashboard_screen.dart';
import 'package:url_launcher/url_launcher.dart';

var apiEndpoint = DotEnv().env['API_URL'].toString();

var fileAPI = apiEndpoint + 'files/';

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
  User _loggedUser;
  bool _userAvailable = false;

  ///get logged in user
  void getUser() async {
    _loggedUser = await TokenStorageService.userDataOrEmpty;
    setState(() {
      _userAvailable = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    var user = widget.user;
    var vIcon = user.verified ? Icons.verified : Icons.cancel;
    var vIconColor = user.verified ? Colors.greenAccent : Colors.redAccent;

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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue.shade800,
        actions: [HomeButton()],
      ),
      body: SafeArea(
          child: FutureBuilder<dynamic>(
              future: UserService.getLoggedInUser(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                User loggedUser;

                if (snapshot.hasData) {
                  loggedUser = snapshot.data;
                  return Center(
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Center(
                          child: Text(
                            user.fullName,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 35.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Center(
                          child: Text(
                            getRole(user),
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 27.0,
                        ),
                        Center(
                          child: CircleAvatar(
                            radius: 90.0,
                            backgroundImage: user.profileImageURL ==
                                    'default.png'
                                ? AssetImage('images/default.png')
                                : NetworkImage(fileAPI + user.profileImageURL),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Center(
                          child: Text(
                            user.username,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.black87,
                              fontSize: 20.0,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold,
                            ),
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
                                  user.title == null ? '' : user.title.name,
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
                        GestureDetector(
                          onTap: () {
                            _launchUrl("tel:${user.telephoneNumber}");
                          },
                          child: Card(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 25.0),
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
                        ),
                        GestureDetector(
                          onTap: () {
                            var subject = "";
                            var body = "Dear " + user.fullName;
                            _launchUrl(
                                "mailto:${user.email}?subject=$subject&body=$body");
                          },
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 25.0),
                            child: ListTile(
                              leading: Icon(
                                Icons.email,
                                color: Colors.blue.shade900,
                              ),
                              title: Text(
                                user.email,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.blueGrey.shade900,
                                    fontFamily: 'Source Sans Pro'),
                              ),
                            ),
                          ),
                        ),

                        ///user leave data
                        if (_userAvailable &&
                            _loggedUser.highestRoleIndex == 2 &&
                            user.highestRoleIndex < 2)
                          Column(
                            children: [
                              SizedBox(
                                height: 20.0,
                                child: Divider(
                                  color: Colors.lightBlueAccent.shade100,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MoreLeaveDetails(
                                        userId: user.id,
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 25.0),
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.directions_walk,
                                      color: Colors.blueAccent,
                                      size: 28,
                                    ),
                                    title: Text(
                                      'User Leave Details',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        color: Colors.blueGrey.shade900,
                                        fontFamily: 'Source Sans Pro',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        Container(
                          margin: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 40.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  if (loggedUser.highestRoleIndex > 2)
                                    if (!isTeamLead)
                                      IconButton(
                                        icon: Icon(
                                          Icons.admin_panel_settings,
                                          color: isAdmin
                                              ? Colors.white
                                              : Colors.black87,
                                          size: 35.0,
                                        ),
                                        onPressed: () async {
                                          if (isAdmin) {
                                            var confirmed =
                                                await displayDowngradeAdminSureDialog(
                                                    context);
                                            if (confirmed) {
                                              bool success = await AdminService
                                                  .handleAdminRoleAssignment(
                                                      user.username, isAdmin);
                                              handleSuccess(
                                                  success, context, user.id);
                                            }
                                          } else {
                                            var confirmed =
                                                await displayUpliftToAdminSureDialog(
                                                    context);
                                            if (confirmed) {
                                              bool success = await AdminService
                                                  .handleAdminRoleAssignment(
                                                      user.username, isAdmin);

                                              await handleSuccess(
                                                  success, context, user.id);
                                            }
                                          }
                                        },
                                      ),
                                  if (!isAdmin &&
                                      loggedUser.highestRoleIndex == 2)
                                    IconButton(
                                      icon: Icon(
                                        Icons.accessibility_new,
                                        color: isTeamLead
                                            ? Colors.white
                                            : Colors.black87,
                                        size: 35.0,
                                      ),
                                      onPressed: () async {
                                        if (isTeamLead) {
                                          var confirmed =
                                              await displayDowngradeTeamLeadSureDialog(
                                                  context);
                                          if (confirmed) {
                                            bool success = await AdminService
                                                .handleTeamLeadRoleAssignment(
                                                    user.username, isTeamLead);
                                            await handleSuccess(
                                                success, context, user.id);
                                          }
                                        } else {
                                          var confirmed =
                                              await displayUpliftToTeamLeadSureDialog(
                                                  context);
                                          if (confirmed) {
                                            bool success = await AdminService
                                                .handleTeamLeadRoleAssignment(
                                                    user.username, isTeamLead);
                                            await handleSuccess(
                                                success, context, user.id);
                                          }
                                        }
                                      },
                                    ),
                                  if (user.updated)
                                    IconButton(
                                      icon: Icon(
                                        Icons.update,
                                        color: Colors.black,
                                        size: 35.0,
                                      ),
                                      onPressed: () async {
                                        UserHistory uh = await UserService
                                            .fetchUserHistoryById(user.id);

                                        // displayHistory(context, user, uh);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserUpdateTable(user, uh)));
                                      },
                                    ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete_forever,
                                      color: user.verified
                                          ? Colors.black87
                                          : Colors.white,
                                      size: 35.0,
                                    ),
                                    onPressed: () async {
                                      if (user.verified) {
                                        displayDialog(
                                            context,
                                            "Invalid Operation",
                                            "Only un-verified users can be deleted");
                                      } else {
                                        var confirmed =
                                            await displayDeleteUserSureDialog(
                                                context);

                                        if (confirmed) {
                                          bool success =
                                              await AdminService.deleteUser(
                                                  user.id);
                                          if (success) {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.pushNamed(context,
                                                UserManagementDashboard.id);
                                          } else {
                                            operationFailed(context);
                                          }
                                        }
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
                                      var confirmed =
                                          await handleVerifySureDialog(
                                              context, user.verified);

                                      if (confirmed) {
                                        bool success = await AdminService
                                            .handleUserVerification(
                                                user.id, user.verified);
                                        await handleSuccess(
                                            success, context, user.id);
                                      }
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Text('Error'),
                  );
                }
              })),
    );
  }

  String getRole(User user) {
    if (user.highestRoleIndex == 0) {
      return "Team Member";
    } else if (user.highestRoleIndex == 1) {
      return "Team Leader";
    } else if (user.highestRoleIndex == 2) {
      return "Admin";
    } else if (user.highestRoleIndex == 3) {
      return "Super Admin";
    }
    return "";
  }
}

handleSuccess(success, context, userId) async {
  if (success) {
    var user = await UserService.getUserById(userId);

    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pushNamed(context, UserManagementDashboard.id);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => UserDetails(user: user)));
  } else {
    operationFailed(context);
  }
}

_launchUrl(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  }
}
