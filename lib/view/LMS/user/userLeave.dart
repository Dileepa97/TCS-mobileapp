import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/leave/LeaveResponse.dart';
import 'package:timecapturesystem/services/leaveService.dart';

class UserLeave extends StatefulWidget {
  @override
  _UserLeaveState createState() => _UserLeaveState();
}

class _UserLeaveState extends State<UserLeave> {
  final LeaveService _leaveService = LeaveService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Leave',
        ),
        leading: BackButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/');
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: RaisedButton(
              color: Colors.blueAccent,
              child: Text(
                'Request Leave',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/leaveRequest');
              },
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: RaisedButton(
              color: Colors.blueAccent,
              child: Text(
                'Check All Leaves',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/allLeaves');
                // List<LeaveResponse> leaves = await _leaveService.fetchLeaves();
                // print(leaves);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     //builder: (context) => LeaveBoxList(items: leaves),
                //      MyApp(),
                //   ),
                // );
              },
            ),
          ),
        ],
      ),
    );
  }
}
