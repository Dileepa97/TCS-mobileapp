import 'dart:io';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import 'package:timecapturesystem/models/leave/LeaveResponse.dart';
import 'package:timecapturesystem/services/leaveService.dart';

class AllLeave extends StatefulWidget {
  @override
  _AllLeaveState createState() => _AllLeaveState();
}

class _AllLeaveState extends State<AllLeave> {
  LeaveService _leaveService = LeaveService();
  List<LeaveResponse> tags = List<LeaveResponse>();

  void data() async {
    var data = await _leaveService.getData() as List;

    List<LeaveResponse> abc = data
        .map((leaveResponseJson) => LeaveResponse.fromJson(leaveResponseJson))
        .toList();
    //print(data[11]);
    if (this.mounted) {
      setState(() {
        tags = abc;
      });
    }
    //print(tags.length);
  }

  @override
  Widget build(BuildContext context) {
    data();
    //print(tags.length);
    //print(tags);
    // sleep(Duration(seconds: 2));

    return Scaffold(
      appBar: AppBar(
        title: Text('All leaves'),
        leading: BackButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/userLeave');
          },
        ),
      ),
      body: ListView.builder(
        itemCount: tags.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: LeaveBox(item: tags[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LeavePage(item: tags[index]),
                ),
              );
            },
          );
        },
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Something Wrong !'),
    //     backgroundColor: Colors.red,
    //   ),
    //   body: Center(
    //       child: Text('Cannot Connect to the server or no available data')),
    // );
  }
}

class LeavePage extends StatelessWidget {
  LeavePage({Key key, this.item}) : super(key: key);
  final LeaveResponse item;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.item.userId),
      ),
      body: Center(
        child: Container(
            margin: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  this.item.leaveType + ' leave',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Start date: ' + this.item.leaveStartDate.toString(),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'End date: ' + this.item.leaveEndDate.toString(),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Leave Status: ' +
                      EnumToString.convertToString(this.item.leaveStatus),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class LeaveBox extends StatelessWidget {
  LeaveBox({Key key, this.item}) : super(key: key);
  final LeaveResponse item;

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
        height: 100,
        child: Card(
          shadowColor: Colors.black,
          borderOnForeground: true,
          color: Colors.lightBlue[200],
          elevation: 8,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(this.item.userId,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(this.item.leaveType + ' leave'),
                            Text('Start Date: ' +
                                this.item.leaveStartDate.year.toString() +
                                '-' +
                                this.item.leaveStartDate.month.toString() +
                                '-' +
                                this.item.leaveStartDate.day.toString()),
                          ],
                        )))
              ]),
        ));
  }
}
