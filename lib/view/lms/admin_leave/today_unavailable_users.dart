import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: Text(
          'User Unavailability Today',
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
          Divider(
            height: 1,
          ),
          FutureBuilder<dynamic>(
            future: _leaveService.getUnavailableUsersToday(
                context, _year, _month, _day),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              Widget child;
              if (snapshot.hasData) {
                List<NotAvailableUsers> leaves;

                if (snapshot.data == 400) {
                  child = Center(child: Text("Bad request"));
                } else if (snapshot.data == 204) {
                  child = Center(child: Text("No absent users for today"));
                } else if (snapshot.data == 1) {
                  child = Center(child: Text("An unknown error occured"));
                } else {
                  leaves = snapshot.data;

                  child = Text("OK");
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
