import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/components/leave_component/error_texts.dart';
import 'package:timecapturesystem/components/leave_component/leave_cancel_card.dart';
import 'package:timecapturesystem/models/lms/leave.dart';

import 'package:timecapturesystem/services/lms/leave_service.dart';

class OngoingLeaveCancellationManager extends StatefulWidget {
  static const String id = "ongoing_leave_cancellation_manager";

  @override
  _OngoingLeaveCancellationManagerState createState() =>
      _OngoingLeaveCancellationManagerState();
}

class _OngoingLeaveCancellationManagerState
    extends State<OngoingLeaveCancellationManager> {
  LeaveService _leaveService = LeaveService();
  List<Leave> _leaveList;

  int _year = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,

      ///app bar
      appBar: AppBar(
        title: Text(
          'Cancel requests',
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
              if (_leaveList != null) {
                setState(() {
                  _leaveList.removeRange(0, _leaveList.length);
                });
              } else {
                setState(() {});
              }
            },
          ),
          HomeButton(),
        ],
      ),

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
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),

            ///leave cancel detail list
            FutureBuilder<dynamic>(
              future: _leaveService.getLeavesByStatusAndYear(
                  context, 'ONGOING_CANCEL_REQUESTED', _year),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                Widget child;
                if (snapshot.hasData) {
                  if (snapshot.data == 204) {
                    child = CustomErrorText(
                        text: "No ongoing cancel request to display");
                  } else if (snapshot.data == 1) {
                    child = ServerErrorText();
                  } else if (snapshot.data == -1) {
                    child = ConnectionErrorText();
                  } else {
                    _leaveList = snapshot.data;

                    child = ListView.builder(
                      itemCount: _leaveList.length,
                      itemBuilder: (context, index) {
                        return LeaveCancelCard(
                          data: _leaveList[index],
                        );
                      },
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
        setState(() => _year = value);
        // integerNumberPicker.animateInt(value);
      }
    });
  }
}
