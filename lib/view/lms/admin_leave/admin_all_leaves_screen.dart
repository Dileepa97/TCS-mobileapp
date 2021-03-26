import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:timecapturesystem/components/home_button.dart';

import 'package:timecapturesystem/components/leave_component/leave_list_view_builder.dart';
import 'package:timecapturesystem/models/lms/leave.dart';
import 'package:timecapturesystem/services/lms/leave_service.dart';
import 'package:numberpicker/numberpicker.dart';

//done
class AdminAllLeaves extends StatefulWidget {
  static const String id = "admin_all_leaves";

  @override
  _AdminAllLeavesState createState() => _AdminAllLeavesState();
}

class _AdminAllLeavesState extends State<AdminAllLeaves> {
  LeaveService _leaveService = LeaveService();
  int _year = DateTime.now().year;
  int _month = DateTime.now().month;

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
      body: Column(
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
                ///icon
                CircleAvatar(
                  child: Icon(
                    Icons.calendar_today_rounded,
                    size: 20,
                  ),
                ),

                ///Year picker
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
                    _showIntDialog(DateTime.now().year - 1, DateTime.now().year,
                        this._year, true);
                  },
                ),

                ///month picker
                GestureDetector(
                  child: Text(
                    'Month : $_month',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.blue[700],
                      fontSize: 18,
                      fontFamily: 'Source Sans Pro',
                    ),
                  ),
                  onTap: () {
                    _showIntDialog(1, 12, this._month, false);
                  },
                ),
              ],
            ),
          ),

          ///leave list builder
          FutureBuilder<dynamic>(
            future: _leaveService.getLeavesByMonth(context, _year, _month),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              Widget child;
              List<Leave> leaves;

              if (snapshot.hasData) {
                ///Bad request
                if (snapshot.data == 400) {
                  child = Center(
                    child: Text(
                      "Bad request",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }

                ///No data
                else if (snapshot.data == 204) {
                  child = Center(
                    child: Text(
                      "No leave data available for this month",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }

                ///Unknown error
                else if (snapshot.data == 1) {
                  child = Center(
                    child: Text(
                      "An unknown error occured",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }

                ///OK
                else {
                  leaves = snapshot.data;
                  leaves.sort((b, a) => a.startDate.compareTo(b.reqDate));

                  child = LeaveListViewBuilder(
                    list: leaves,
                    isUserLeave: false,
                  );
                }
              }

              ///loading
              else {
                child = Center(
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

              return Expanded(child: child);
            },
          )
        ],
      ),
    );
  }

  ///year and month picker
  Future _showIntDialog(int min, int max, int init, bool isYear) async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 500,
          child: new NumberPickerDialog.integer(
            minValue: min,
            maxValue: DateTime.now().month == 12 && isYear ? max + 1 : max,
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
          ),
        );
      },
    ).then((num value) {
      if (value != null) {
        if (isYear) {
          setState(() => _year = value);
        } else {
          setState(() => _month = value);
        }
      }
    });
  }
}
