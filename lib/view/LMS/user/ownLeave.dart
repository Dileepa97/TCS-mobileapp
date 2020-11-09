import 'package:flutter/material.dart';

class OwnLeave extends StatefulWidget {
  @override
  _OwnLeaveState createState() => _OwnLeaveState();
}

class _OwnLeaveState extends State<OwnLeave> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Leaves',
        ),
      ),
    );
  }
}
