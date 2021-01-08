import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:timecapturesystem/components/leave_component/list_view_builder.dart';
import 'package:timecapturesystem/models/lms/leave.dart';
import 'package:timecapturesystem/models/lms/leave_response.dart';

import 'package:timecapturesystem/services/LMS/leave_service.dart';

class OwnLeaves extends StatefulWidget {
  @override
  _OwnLeavesState createState() => _OwnLeavesState();
}

class _OwnLeavesState extends State<OwnLeaves> {
  LeaveService _leaveService = LeaveService();
  List<LeaveResponse> list = List<LeaveResponse>();
  int _year = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My leaves',
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
          Container(
            height: 50,
            width: double.infinity,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  child: Icon(
                    Icons.calendar_today_rounded,
                    size: 20,
                  ),
                ),
                GestureDetector(
                  child: Text(
                    'Year : $_year',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.blue[700],
                      fontSize: 18,
                      fontFamily: 'Source Sans Pro',
                    ),
                  ),
                  onTap: () {
                    _showIntDialog(2020, DateTime.now().year, _year);
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          FutureBuilder<dynamic>(
            future: _leaveService.getLoggedUserLeaves(context, _year),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              Widget child;
              if (snapshot.hasData) {
                List<Leave> leaves;

                if (snapshot.data == 400) {
                  child = Center(child: Text("Bad request"));
                } else if (snapshot.data == 204) {
                  child = Center(
                      child: Text("No leave data available for this year"));
                } else if (snapshot.data == 1) {
                  child = Center(child: Text("An unknown error occured"));
                } else {
                  leaves = snapshot.data;
                  leaves.sort((b, a) => a.startDate.compareTo(b.reqDate));

                  child = LeaveListViewBuilder(
                    list: leaves,
                    isUserLeave: true,
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

  Future _showIntDialog(int min, int max, int init) async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.integer(
          minValue: min,
          maxValue: max,
          step: 1,
          initialIntegerValue: init,
        );
      },
    ).then((num value) {
      if (value != null) {
        setState(() => _year = value);
        // integerNumberPicker.animateInt(value);
      }
    });
  }
}
