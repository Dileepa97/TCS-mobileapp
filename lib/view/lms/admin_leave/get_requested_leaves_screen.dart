import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:timecapturesystem/components/leave_component/custom_drop_down.dart';
import 'package:timecapturesystem/components/leave_component/list_view_builder.dart';
import 'package:timecapturesystem/models/lms/leave.dart';
import 'package:timecapturesystem/models/lms/leave_response.dart';
import 'package:timecapturesystem/models/lms/leave_status.dart';

import 'package:timecapturesystem/services/LMS/leave_service.dart';

import '../check_leaves.dart';

class AllRequestedLeaves extends StatefulWidget {
  @override
  _AllRequestedLeavesState createState() => _AllRequestedLeavesState();
}

class _AllRequestedLeavesState extends State<AllRequestedLeaves> {
  LeaveService _leaveService = LeaveService();
  List<LeaveResponse> list = List<LeaveResponse>();
  bool _spin = true;
  bool _dataAvailable = false;
  int _year = DateTime.now().year;

  String _leaveStatus = 'REQUESTED';

  List<String> _leaveStatuses = [
    'REQUESTED',
    'ACCEPTED',
    'REJECTED',
    'CANCELLED',
    'ONGOING',
    'ONGOING_CANCELED',
    'EXPIRED'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Leaves by Status',
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
                // GestureDetector(
                //   child: Text(
                //     'Year : $_year',
                //     style: TextStyle(
                //       fontWeight: FontWeight.w900,
                //       color: Colors.blue[700],
                //       fontSize: 18,
                //       fontFamily: 'Source Sans Pro',
                //     ),
                //   ),
                //   onTap: () {
                //     _showIntDialog(2020, DateTime.now().year + 1, _year, true);
                //   },
                // ),
                CustomDropDown(
                  keyString: 'Leave Status',
                  item: _leaveStatus,
                  items: _leaveStatuses,
                  onChanged: (String newValue) {
                    setState(() {
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
          FutureBuilder<dynamic>(
            future: _leaveService.getLeavesByStatus(context, _leaveStatus),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              Widget child;
              if (snapshot.hasData) {
                List<Leave> leaves;

                if (snapshot.data == 400) {
                  child = Center(child: Text("Bad request"));
                } else if (snapshot.data == 204) {
                  child = Center(
                      child: Text("No leave data available for this month"));
                } else if (snapshot.data == 1) {
                  child = Center(child: Text("An unknown error occured"));
                } else {
                  leaves = snapshot.data;
                  leaves.sort((b, a) => a.startDate.compareTo(b.reqDate));

                  child = LeaveListViewBuilder(
                    list: leaves,
                    isUserLeave: false,
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
      // this._dataAvailable
      //     ? LeaveListViewBuilder(
      //         //list: list,
      //         isUserLeave: false,
      //       )
      //     : Center(
      //         child: Text('Cannot Connect to the server or no available data')),
    );
  }

  // void data() async {
  //   var data = await _leaveService.getLeavesByStatus('REQUESTED') as List;

  //   List<LeaveResponse> arr = data
  //       .map((leaveResponseJson) => LeaveResponse.fromJson(leaveResponseJson))
  //       .toList();

  //   arr.sort((b, a) => a.reqDate.compareTo(b.reqDate));

  //   if (this.mounted) {
  //     setState(() {
  //       list = arr;
  //       this._spin = false;
  //       this._dataAvailable = true;
  //     });
  //   }
  // }

  Future _showIntDialog(int min, int max, int init, bool isYear) async {
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
        if (isYear) {
          setState(() => _year = value);
        } else {
          // setState(() => _month = value);
        }

        // integerNumberPicker.animateInt(value);
      }
    });
  }
}
