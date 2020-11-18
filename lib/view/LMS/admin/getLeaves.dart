import 'dart:io';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import 'package:timecapturesystem/models/leave/LeaveResponse.dart';
import 'package:timecapturesystem/services/leaveService.dart';
import 'package:timecapturesystem/view/LMS/admin/leaveDetailsPage.dart';

import 'leaveCard.dart';

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
            child: LeaveCard(item: tags[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LeaveDetailsPage(item: tags[index]),
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
