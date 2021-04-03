import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/components/leave_component/absent_user_builder.dart';
import 'package:timecapturesystem/components/leave_component/error_texts.dart';
import 'package:timecapturesystem/models/lms/not_available_users.dart';
import 'package:timecapturesystem/services/lms/leave_service.dart';

class WeekUnavailableUserScreen extends StatefulWidget {
  static const String id = "admin_week_unavailable_users";
  @override
  _WeekUnavailableUserScreen createState() => _WeekUnavailableUserScreen();
}

class _WeekUnavailableUserScreen extends State<WeekUnavailableUserScreen> {
  LeaveService _leaveService = LeaveService();
  List<NotAvailableUsers> _users;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,

      ///app bar
      appBar: AppBar(
        title: Text(
          'Week absent users',
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
                  _users.removeRange(0, _users.length);
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
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),

          ///absent day list
          FutureBuilder<dynamic>(
            future: _leaveService.getUnavailableUsersWeek(context),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              Widget child;
              if (snapshot.hasData) {
                if (snapshot.data == 204) {
                  child =
                      CustomErrorText(text: "No absent users for this week");
                } else if (snapshot.data == 1) {
                  child = ServerErrorText();
                } else if (snapshot.data == -1) {
                  child = ConnectionErrorText();
                } else {
                  _users = snapshot.data;

                  child = AbsentUserListViewBuilder(
                    list: _users,
                    isTeam: false,
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
    );
  }
}
