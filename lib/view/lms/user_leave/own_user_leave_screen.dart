import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/components/leave_component/error_texts.dart';
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

  List<Leave> leaves = [];
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
                        fontWeight: FontWeight.w500,
                        color: Colors.blue[700],
                        fontSize: 17,
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
                      if (leaves != null) {
                        setState(() {
                          leaves.removeRange(0, leaves.length);
                        });
                      } else {
                        setState(() {});
                      }
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
                    _child = CustomErrorText(
                        text: 'No leave data available to show for this year.');
                  } else if (snapshot.data == 1) {
                    _child = ServerErrorText();
                  } else if (snapshot.data == -1) {
                    _child = ConnectionErrorText();
                  } else {
                    leaves = snapshot.data;
                    leaves.sort((b, a) => a.startDate.compareTo(b.startDate));

                    _child = LeaveListViewBuilder(
                      list: leaves,
                      isUserLeave: true,
                    );
                  }
                } else {
                  _child = LoadingText();
                }

                return Expanded(child: _child);
              },
            )
          ],
        ),
      ),
    );
  }

  ///year picker
  Future _showIntDialog(int min, int max, int init) async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.integer(
          minValue: min,
          maxValue: DateTime.now().month == 12 ? max + 1 : max,
          step: 1,
          initialIntegerValue: init,
          textStyle: TextStyle(
            fontFamily: 'Source Sans Pro',
            fontSize: 20,
          ),
          selectedTextStyle: TextStyle(
            fontFamily: 'Source Sans Pro',
            fontSize: 25,
            color: Colors.lightBlue.shade800,
          ),
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
