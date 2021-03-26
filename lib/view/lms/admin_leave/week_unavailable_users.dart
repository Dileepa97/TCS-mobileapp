import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/leave_component/absent_user_builder.dart';
import 'package:timecapturesystem/models/lms/not_available_users.dart';
import 'package:timecapturesystem/services/lms/leave_service.dart';

class WeekUnavailableUserScreen extends StatefulWidget {
  @override
  _WeekUnavailableUserScreen createState() => _WeekUnavailableUserScreen();
}

class _WeekUnavailableUserScreen extends State<WeekUnavailableUserScreen> {
  LeaveService _leaveService = LeaveService();

  int _year = DateTime.now().year;
  int _month = DateTime.now().month;
  int _day = DateTime.now().day;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,
      appBar: AppBar(
        title: Text('Week absent users'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.lightBlue.shade800,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          FutureBuilder<dynamic>(
            future: _leaveService.getUnavailableUsersWeek(context),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              Widget child;
              if (snapshot.hasData) {
                List<NotAvailableUsers> users;

                if (snapshot.data == 400) {
                  child = Center(child: Text("Bad request"));
                } else if (snapshot.data == 204) {
                  child = Center(child: Text("No absent users for this week"));
                } else if (snapshot.data == 1) {
                  child = Center(child: Text("An unknown error occured"));
                } else {
                  users = snapshot.data;

                  child = AbsentUserListViewBuilder(
                    list: users,
                  );
                }
              } else {
                child = Center(child: Text("Please wait..."));
              }

              return Expanded(child: child);
            },
          )
        ],
      ),
    );
  }
}
