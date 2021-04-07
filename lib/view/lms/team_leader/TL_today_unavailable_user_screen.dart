import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/components/leave_component/absent_user_card.dart';
import 'package:timecapturesystem/components/leave_component/error_texts.dart';
import 'package:timecapturesystem/models/lms/not_available_users.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/services/lms/leave_service.dart';
import 'package:timecapturesystem/services/other/storage_service.dart';

class TLTodayUnavailableUserScreen extends StatefulWidget {
  static const String id = "team_leader_today_unavailable_users";
  @override
  _TLTodayUnavailableUserScreenState createState() =>
      _TLTodayUnavailableUserScreenState();
}

class _TLTodayUnavailableUserScreenState
    extends State<TLTodayUnavailableUserScreen> {
  LeaveService _leaveService = LeaveService();
  NotAvailableUsers _users;

  int _year = DateTime.now().year;
  int _month = DateTime.now().month;
  int _day = DateTime.now().day;

  User _user;
  String _teamId;

  ///get looged-in user team id
  void _getTeamId() async {
    _user = await TokenStorageService.userDataOrEmpty;

    setState(() {
      _teamId = _user.teamId;
    });
  }

  @override
  void initState() {
    super.initState();
    _getTeamId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,

      ///app bar
      appBar: AppBar(
        title: Text(
          'Today absent users',
          style: TextStyle(
            fontFamily: 'Source Sans Pro',
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.lightBlue.shade800,
        actions: [
          GestureDetector(
            child: Icon(
              Icons.refresh,
            ),
            onTap: () {
              if (_users != null) {
                setState(() {
                  _users = null;
                });
              } else {
                setState(() {});
              }
            },
          ),
          HomeButton(),
        ],
      ),

      ///body
      body: SafeArea(
        child: Column(
          children: [
            ///absent user list
            FutureBuilder<dynamic>(
              future: _leaveService.getTeamUnavailableUsersToday(
                  context, _year, _month, _day, _teamId),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                Widget child;
                if (snapshot.hasData) {
                  if (snapshot.data == 204) {
                    child = CustomErrorText(text: "No absent users for today");
                  } else if (snapshot.data == 1) {
                    child = ServerErrorText();
                  } else if (snapshot.data == -1) {
                    child = ConnectionErrorText();
                  } else {
                    _users = snapshot.data;

                    child = ListView.builder(
                      itemCount: _users.users.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: AbsentUserCard(
                            userData: _users.users[index],
                            isTeam: true,
                          ),
                        );
                      },
                    );
                  }
                } else {
                  child = LoadingText();
                }

                return Expanded(child: child);
              },
            )
          ],
        ),
      ),
    );
  }
}
