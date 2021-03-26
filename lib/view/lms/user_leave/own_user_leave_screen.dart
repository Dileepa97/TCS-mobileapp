import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:numberpicker/numberpicker.dart';

import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/components/leave_component/leave_list_view_builder.dart';
import 'package:timecapturesystem/models/lms/leave.dart';

import 'package:timecapturesystem/services/LMS/leave_service.dart';

class OwnUserLeaves extends StatefulWidget {
  static const String id = "user_all_leaves";
  @override
  _OwnUserLeavesState createState() => _OwnUserLeavesState();
}

class _OwnUserLeavesState extends State<OwnUserLeaves> {
  LeaveService _leaveService = LeaveService();
  // List<LeaveResponse> list = List<LeaveResponse>();
  List<Leave> leaves;
  int _year = DateTime.now().year;
  Widget _child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,

      ///app bar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue.shade800,
        title: Text(
          'All Leaves',
          style: TextStyle(
            fontFamily: 'Source Sans Pro',
          ),
        ),
        centerTitle: true,
        actions: [
          HomeButton(),
        ],
      ),

      ///body
      body: SafeArea(
        child: Column(
          children: [
            ///top menu
            Container(
              height: 50,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ///Icon
                  CircleAvatar(
                    child: Icon(
                      Icons.calendar_today_rounded,
                      size: 20,
                    ),
                  ),

                  ///year picker
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
                      _showIntDialog(
                          DateTime.now().year - 1, DateTime.now().year, _year);
                    },
                  ),

                  ///refresh button
                  GestureDetector(
                    child: Icon(
                      Icons.refresh,
                      size: 25,
                      color: Colors.lightBlue.shade800,
                    ),
                    onTap: () {
                      setState(() {
                        leaves.removeRange(0, leaves.length);
                      });
                    },
                  ),
                ],
              ),
            ),

            ///list builder
            FutureBuilder<dynamic>(
              future: _leaveService.getLoggedUserLeaves(context, _year),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == 204) {
                    _child = Center(
                      child: Text(
                        "No leave data available to show for this year.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else if (snapshot.data == 1) {
                    _child = Center(
                      child: Text(
                        "An unknown error occured. \nPlease try again later",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else if (snapshot.data == -1) {
                    _child = Center(
                      child: Text(
                        "Connection Error. \nPlease check your connection and try again later",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    leaves = snapshot.data;
                    leaves.sort((b, a) => a.startDate.compareTo(b.reqDate));

                    _child = LeaveListViewBuilder(
                      list: leaves,
                      isUserLeave: true,
                    );
                  }
                } else {
                  _child = Center(
                    child: Column(
                      children: [
                        SpinKitCircle(
                          color: Colors.white,
                          size: 50.0,
                        ),
                        Text(
                          "Please wait...",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  );
                }

                return Expanded(child: _child);
              },
            )
          ],
        ),
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
