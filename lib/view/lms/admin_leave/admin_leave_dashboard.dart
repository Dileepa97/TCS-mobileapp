import 'package:flutter/material.dart';

class AdminLeaveDashBoard extends StatefulWidget {
  @override
  _AdminLeaveDashBoardState createState() => _AdminLeaveDashBoardState();
}

class _AdminLeaveDashBoardState extends State<AdminLeaveDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'Get leaves',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/adminGetLeaves');
              },
            ),
          ),
        ],
      ),
    );
  }
}
