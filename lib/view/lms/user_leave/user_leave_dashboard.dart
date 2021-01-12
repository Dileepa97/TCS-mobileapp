import 'package:flutter/material.dart';

class UserLeaveDashboard extends StatefulWidget {
  @override
  _UserLeaveDashboardState createState() => _UserLeaveDashboardState();
}

class _UserLeaveDashboardState extends State<UserLeaveDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                Navigator.pushNamed(context, '/requestFirstScreen');
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
                'Check My Leaves',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/ownLeave');
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
                'My Leaves Types',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                setState(() {
                  // data();
                });
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return UserLeaveAvailable(list: this.list);
                // }));
                Navigator.pushNamed(context, '/availableUserLeaves');
              },
            ),
          ),
        ],
      ),
    );
  }
}
