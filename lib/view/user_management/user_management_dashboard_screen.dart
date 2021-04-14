import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/managers/orientation.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/services/user/user_service.dart';
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
  List<User> users = [];

  String filterType = 'All';

  List<String> filterTypes = ['All', 'Verified', 'Not Verified', 'Others'];
  User loggedUser;

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  void _onRefresh() async {
    loggedUser = await UserService.getLoggedInUser();

    users = await UserService.getAllUsersByFilterType(
        context, filterType, loggedUser.highestRoleIndex);

    if (loggedUser.highestRoleIndex == 2) {
      if (!filterTypes.contains("Team Leads")) {
        filterTypes.add("Team Leads");
      }
    } else if (loggedUser.highestRoleIndex == 3) {
      if (!filterTypes.contains("Admins")) {
        filterTypes.add("Admins");
      }
    }
    if (users != null) {
      if (users != [] || users.length > 0) {
        users = users.reversed.toList();
      }
    }
    if (mounted) setState(() {});
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    OrientationManager.enableRotation();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "User Management",
        ),
        backgroundColor: Colors.lightBlue.shade800,
        actions: [HomeButton()],
      ),
      backgroundColor: Colors.lightBlue.shade800,
      body: SafeArea(
        child: SmartRefresher(
          enablePullDown: true,
          header: ClassicHeader(
            textStyle: TextStyle(color: Colors.white),
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: (users != null && users.length > 0)
              ? ListView.builder(
                  itemBuilder: (c, i) => Center(
                    child: UserCard(
                      user: users[i],
                      loggedUser: loggedUser,
                    ),
                  ),
                  itemExtent: 80.0,
                  itemCount: users.length,
                )
              : Center(
                  child: Container(
                    child: Text(
                      'No users to manage on selected filter',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
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

class CustomDropDown extends StatelessWidget {
  final String keyString;
  final dynamic item;
  final dynamic items;
  final dynamic onChanged;

  const CustomDropDown({this.keyString, this.item, this.items, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropdownButton<String>(
          value: item,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.blue[700],
          ),
          iconSize: 20,

          ///underline
          underline: Container(
            color: Colors.white,
          ),

          ///onchange
          onChanged: onChanged,

          ///drop down lists
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value.substring(0, 1) +
                    value
                        .substring(1)
                        .toLowerCase()
                        .replaceFirst('_', '\n')
                        .replaceFirst('_', ' '),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.blue[700],
                  fontSize: 17,
                  fontFamily: 'Source Sans Pro',
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
