import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/components/leave_component/leave_option_builder.dart';
import 'package:timecapturesystem/models/lms/leave_option.dart';
import 'package:timecapturesystem/services/LMS/leave_availability_service.dart';

class UserLeaveAvailable extends StatefulWidget {
  static const String id = "user_leave_availability";
  @override
  _UserLeaveAvailableState createState() => _UserLeaveAvailableState();
}

class _UserLeaveAvailableState extends State<UserLeaveAvailable> {
  int _year = DateTime.now().year;
  LeaveAvailabilityService _availabilityService = LeaveAvailabilityService();
  List<LeaveOption> _list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,

      ///app bar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue.shade800,
        title: Text(
          'My leave availability',
          style: TextStyle(
            fontFamily: 'Source Sans Pro',
          ),
        ),
        centerTitle: true,
        actions: [
          HomeButton(),
        ],
      ),

      body: SafeArea(
        child: Column(children: [
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
                    if (_list != null) {
                      setState(() {
                        _list.removeRange(0, _list.length);
                      });
                    } else {
                      setState(() {});
                    }
                  },
                ),
              ],
            ),
          ),

          ///data builder
          FutureBuilder<dynamic>(
            future: _availabilityService.getLoggedUserLeaveAvailability(
                context, _year),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              Widget child;
              if (snapshot.hasData) {
                if (snapshot.data == 204) {
                  child = Center(
                    child: Text(
                      "No leave availability data to show for this year.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                } else if (snapshot.data == 1) {
                  child = Center(
                    child: Text(
                      "An unknown error occured. \nPlease try again later",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                } else if (snapshot.data == -1) {
                  child = Center(
                    child: Text(
                      "Connection Error. \nPlease check your connection and try again later",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                } else {
                  _list = snapshot.data;
                  child = LeaveOptionBuilder(
                    list: _list,
                    isHorizontal: false,
                  );
                }
              } else {
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
          ),
        ]),
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
