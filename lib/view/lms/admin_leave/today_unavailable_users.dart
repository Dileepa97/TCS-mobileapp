import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/leave_component/absent_user_builder.dart';
import 'package:timecapturesystem/components/leave_component/absent_user_card.dart';
import 'package:timecapturesystem/models/lms/not_available_users.dart';
import 'package:timecapturesystem/services/lms/leave_service.dart';

class TodayUnavailableUserScreen extends StatefulWidget {
  @override
  _TodayUnavailableUserScreenState createState() =>
      _TodayUnavailableUserScreenState();
}

class _TodayUnavailableUserScreenState
    extends State<TodayUnavailableUserScreen> {
  LeaveService _leaveService = LeaveService();

  int _year = DateTime.now().year;
  int _month = DateTime.now().month;
  int _day = DateTime.now().day;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,
      appBar: AppBar(
        title: Text('Today absent users'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.lightBlue.shade800,
      ),
      body: Column(
        children: [
          FutureBuilder<dynamic>(
            future: _leaveService.getUnavailableUsersToday(
                context, _year, _month, _day),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              Widget child;
              if (snapshot.hasData) {
                NotAvailableUsers users;

                if (snapshot.data == 400) {
                  child = Center(child: Text("Bad request"));
                } else if (snapshot.data == 204) {
                  child = Center(child: Text("No absent users for today"));
                } else if (snapshot.data == 1) {
                  child = Center(child: Text("An unknown error occured"));
                } else {
                  users = snapshot.data;
                  print(users.users.length);
                  child = ListView.builder(
                    itemCount: users.users.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: AbsentUserCard(userData: users.users[index]),
                      );
                    },
                  );
                  // child = Center(child: Text("ok"));
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
