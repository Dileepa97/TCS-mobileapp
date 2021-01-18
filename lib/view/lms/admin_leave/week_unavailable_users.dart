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
      appBar: AppBar(
        title: Text(
          'User Unavailability Week',
          style: TextStyle(color: Colors.black),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        elevation: 0,
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
