import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/components/leave_component/error_texts.dart';
import 'package:timecapturesystem/components/leave_component/leave_user_data_builders.dart';
import 'package:timecapturesystem/models/lms/leave.dart';
import 'package:timecapturesystem/services/lms/leave_service.dart';
import 'package:timecapturesystem/view/lms/admin_leave/admin_leave_detail_page.dart';
import 'package:timecapturesystem/view/lms/user_leave/user_leave_card.dart';

class AdminUserLeaveListScreen extends StatefulWidget {
  static const String id = "admin_user_leave_list";

  final String userId;

  const AdminUserLeaveListScreen({Key key, this.userId}) : super(key: key);

  @override
  _AdminUserLeaveListScreenState createState() =>
      _AdminUserLeaveListScreenState();
}

class _AdminUserLeaveListScreenState extends State<AdminUserLeaveListScreen> {
  List<Leave> _leaves;

  int _year = DateTime.now().year;

  LeaveService _leaveService = LeaveService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,

      ///app bar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue.shade800,
        title: UserNameText(userId: widget.userId, fontSize: 18),
        centerTitle: true,
        actions: [
          GestureDetector(
            child: Icon(
              Icons.refresh,
            ),
            onTap: () {
              if (_leaves != null) {
                setState(() {
                  _leaves.removeRange(0, _leaves.length);
                });
              } else {
                setState(() {});
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
            ///year menu
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

            ///leave list builder
            FutureBuilder<dynamic>(
              future: _leaveService.getLeavesByUserAndYear(
                  context, widget.userId, _year),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                Widget child;

                if (snapshot.hasData) {
                  if (snapshot.data == 204) {
                    child = CustomErrorText(
                        text:
                            "No leave data available for the user in this year");
                  } else if (snapshot.data == 1) {
                    child = ServerErrorText();
                  } else if (snapshot.data == -1) {
                    child = ConnectionErrorText();
                  } else {
                    _leaves = snapshot.data;
                    _leaves.sort((b, a) => a.startDate.compareTo(b.startDate));

                    child = ListView.builder(
                      itemCount: _leaves.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: UserLeaveCard(item: _leaves[index]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminLeaveDetailsPage(
                                  item: _leaves[index],
                                  isMoreUserLeave: true,
                                  isOngoing: false,
                                ),
                              ),
                            );
                          },
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
