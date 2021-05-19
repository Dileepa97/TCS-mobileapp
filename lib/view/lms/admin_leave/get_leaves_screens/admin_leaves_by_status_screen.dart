import 'package:flutter/material.dart';

import 'package:numberpicker/numberpicker.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/components/leave_component/custom_drop_down.dart';
import 'package:timecapturesystem/components/leave_component/error_texts.dart';
import 'package:timecapturesystem/components/leave_component/leave_list_view_builder.dart';
import 'package:timecapturesystem/models/lms/leave.dart';
import 'package:timecapturesystem/models/lms/leave_response.dart';

import 'package:timecapturesystem/services/LMS/leave_service.dart';

class AdminLeaveByStatus extends StatefulWidget {
  static const String id = "admin_leave_by_status";

  @override
  _AdminLeaveByStatusState createState() => _AdminLeaveByStatusState();
}

class _AdminLeaveByStatusState extends State<AdminLeaveByStatus> {
  LeaveService _leaveService = LeaveService();
  List<LeaveResponse> list = List<LeaveResponse>();

  int _year = DateTime.now().year;

  List<Leave> _leaves;

  String _leaveStatus = 'REQUESTED';

  List<String> _leaveStatuses = [
    'REQUESTED',
    'ACCEPTED',
    'REJECTED',
    'CANCELLED',
    'ONGOING',
    'ONGOING_CANCEL_REQUESTED',
    'ONGOING_CANCELLED',
    'EXPIRED'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,

      ///app bar
      appBar: AppBar(
        title: Text(
          'Leaves by status',
          style: TextStyle(
            fontFamily: 'Source Sans Pro',
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.lightBlue.shade800,
        actions: [
          GestureDetector(
            child: Icon(
              Icons.refresh,
            ),
            onTap: () {
              if (_leaves != null) {
                setState(() {
                  _leaves.removeRange(0, _leaves.length);
                  _year = DateTime.now().year;
                  _leaveStatus = 'REQUESTED';
                });
              } else {
                setState(() {
                  _year = DateTime.now().year;
                  _leaveStatus = 'REQUESTED';
                });
              }
            },
          ),
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
                  ///year picker
                  GestureDetector(
                    child: Text(
                      'Year : $_year',
                      style: TextStyle(
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

                  ///leave status picker
                  CustomDropDown(
                    keyString: 'Leave Status',
                    item: _leaveStatus,
                    items: _leaveStatuses,
                    onChanged: (String newValue) {
                      setState(() {
                        if (_leaves != null)
                          _leaves.removeRange(0, _leaves.length);
                        this._leaveStatus = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),

            ///leave list builder
            FutureBuilder<dynamic>(
              future: _leaveService.getLeavesByStatusAndYear(
                  context, _leaveStatus, _year),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                Widget child;
                if (snapshot.hasData) {
                  if (snapshot.data == 204) {
                    child = CustomErrorText(
                        text:
                            "No leave data available for this year and leave status");
                  } else if (snapshot.data == 1) {
                    child = ServerErrorText();
                  } else if (snapshot.data == -1) {
                    child = ConnectionErrorText();
                  } else {
                    _leaves = snapshot.data;
                    _leaves.sort((b, a) => a.startDate.compareTo(b.startDate));

                    child = LeaveListViewBuilder(
                      list: _leaves,
                      isUserLeave: false,
                    );
                  }
                } else {
                  child = LoadingText();
                }

                return Expanded(child: child);
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
        setState(() {
          if (_leaves != null) _leaves.removeRange(0, _leaves.length);
          _year = value;
        });
      }
    });
  }
}
