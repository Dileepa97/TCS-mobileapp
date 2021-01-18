import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:timecapturesystem/components/leave_component/leave_option_builder.dart';

import 'package:timecapturesystem/models/lms/leave_option.dart';
import 'package:timecapturesystem/services/LMS/leave_availability_service.dart';

class UserLeaveAvailable extends StatefulWidget {
  @override
  _UserLeaveAvailableState createState() => _UserLeaveAvailableState();
}

class _UserLeaveAvailableState extends State<UserLeaveAvailable> {
  bool _dataAvailable = false;
  int _year = DateTime.now().year;
  LeaveAvailabilityService _availabilityService = LeaveAvailabilityService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My leave Summery',
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
      body: Column(children: [
        Divider(
          height: 1,
        ),

        ///Year bar
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

        ///Page builder
        FutureBuilder<dynamic>(
          future: _availabilityService.getLoggedUserLeaveAvailability(
              context, _year),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            Widget child;
            if (snapshot.hasData) {
              List<LeaveOption> list = List<LeaveOption>();

              if (snapshot.data == 400) {
                child = Center(child: Text("Bad request"));
              } else if (snapshot.data == 204) {
                child = Center(
                    child: Text(
                        "No leave availability data available for this year"));
              } else if (snapshot.data == 1) {
                child = Center(child: Text("An unknown error occured"));
              } else {
                list = snapshot.data;
                child = LeaveOptionBuilder(list: list);
              }
            } else {
              child = Center(child: Text("Please wait..."));
            }

            return Expanded(child: child);
          },
        ),
      ]),
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
