import 'package:flutter/material.dart';

import 'package:numberpicker/numberpicker.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/components/leave_component/alert_dialogs.dart';
import 'package:timecapturesystem/components/leave_component/custom_drop_down.dart';
import 'package:timecapturesystem/components/leave_component/error_texts.dart';
import 'package:timecapturesystem/components/leave_component/leave_option_builder.dart';

import 'package:timecapturesystem/models/lms/leave_option.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/services/lms/leave_availability_service.dart';
import 'package:timecapturesystem/services/other/storage_service.dart';

import 'leave_request_main_screen.dart';

class FirstRequestScreen extends StatefulWidget {
  static const String id = "user_leave_request_first_screen";

  @override
  _FirstRequestScreenState createState() => _FirstRequestScreenState();
}

//todo:lost connection
class _FirstRequestScreenState extends State<FirstRequestScreen> {
  LeaveAvailabilityService _availabilityService = LeaveAvailabilityService();

  User _user;
  String _gender = 'Male';
  String _leaveType = 'CASUAL';

  double _availableDays;

  bool _isRequest = false;
  bool _isMatOrPat = false;

  LeaveOption _option;
  List<LeaveOption> _list = List<LeaveOption>();

  Widget _child;

  List<String> _leaveTypelistMale = [
    'CASUAL',
    'ANNUAL',
    'MEDICAL',
    'EXTENDED_ANNUAL',
    'EXTENDED_MEDICAL',
    'LIEU',
    'PATERNITY',
  ];

  List<String> _leaveTypelistFemale = [
    'CASUAL',
    'ANNUAL',
    'MEDICAL',
    'EXTENDED_ANNUAL',
    'EXTENDED_MEDICAL',
    'LIEU',
    'MATERNITY',
  ];

  int _year = DateTime.now().year;

  ///get logged in user data
  void getUser() async {
    _user = await TokenStorageService.userDataOrEmpty;
    setState(() {
      this._gender = _user.gender;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,

      ///app bar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue.shade800,
        title: Text(
          'Select Leave Type',
          style: TextStyle(
            fontFamily: 'Source Sans Pro',
          ),
        ),
        centerTitle: true,
        actions: [
          ///refresh button
          GestureDetector(
            child: Icon(
              Icons.refresh,
              size: 25,
            ),
            onTap: () {
              if (_list != null) {
                setState(() {
                  _list.removeRange(0, _list.length);
                  _year = DateTime.now().year;
                  _leaveType = 'CASUAL';
                  _isRequest = false;
                  _isMatOrPat = false;
                });
              } else {
                setState(() {
                  _year = DateTime.now().year;
                  _leaveType = 'CASUAL';
                  _isRequest = false;
                  _isMatOrPat = false;
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
            ///year and type selector
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ///year
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
                          DateTime.now().year, DateTime.now().year, this._year);
                    },
                  ),

                  ///type
                  CustomDropDown(
                    keyString: 'Leave Type',
                    item: this._leaveType,
                    items: this._gender == 'Male'
                        ? this._leaveTypelistMale
                        : this._leaveTypelistFemale,
                    onChanged: (String newValue) {
                      setState(() {
                        this._leaveType = newValue;

                        if (this._leaveType == 'MATERNITY' ||
                            this._leaveType == 'PATERNITY') {
                          this._isMatOrPat = true;
                        } else {
                          this._isMatOrPat = false;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 8,
            ),

            ///build chart
            FutureBuilder<dynamic>(
              future: _availabilityService.getLoggedUserLeaveAvailabilityByType(
                  context, this._year, this._leaveType),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == 204) {
                    this._child = Center(
                      child: Text(
                        "No leave data available to show for this year and type yet \nTry another.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );

                    this._isRequest = false;
                  } else if (snapshot.data == 1) {
                    this._child = ServerErrorText();

                    this._isRequest = false;
                  } else if (snapshot.data == -1) {
                    this._child = ConnectionErrorText();
                    this._isRequest = false;
                  } else {
                    this._option = snapshot.data;
                    _list.removeRange(0, _list.length);
                    _list.add(this._option);

                    this._child = LeaveOptionBuilder(
                      list: _list,
                      isHorizontal: false,
                    );

                    this._availableDays = this._option.allowedDays -
                        (this._option.requestedDays +
                            this._option.approvedDays +
                            this._option.takenDays);

                    if (this._leaveType == 'LIEU' ||
                        this._leaveType == 'EXTENDED_ANNUAL' ||
                        this._leaveType == 'EXTENDED_MEDICAL') {
                      // For LIEU, EXTENDED_ANNUAL, EXTENDED_MEDICAL leave types

                      this._isRequest = true;
                    } else {
                      // For other leave types.

                      if (this._availableDays <= 0.0) {
                        this._isRequest = false;
                      } else
                        this._isRequest = true;
                    }
                  }
                } else {
                  this._child = LoadingText();
                  this._isRequest = false;
                }

                return Expanded(child: this._child);
              },
            ),

            ///request button
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    ///request
                    if (this._isRequest == true) {
                      setState(() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LeaveRequestMainScreen(
                            leaveType: this._leaveType,
                            availableDays: this._availableDays,
                            isMatOrPat: this._isMatOrPat,
                          );
                        }));
                      });
                    }

                    ///do not request
                    else {
                      ShowAlertDialog check = ShowAlertDialog();
                      if (this.mounted) {
                        check.showAlertDialog(
                          title: 'Cannot Request !',
                          body: 'You have no available leaves to request.',
                          color: Colors.redAccent,
                          context: context,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                      }
                    }
                  },

                  ///button content
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Create request',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.lightBlue.shade800,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Source Sans Pro',
                        ),
                      ),
                      decoration: BoxDecoration(
                        // border: Border.all(width: 0.0, color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///year intitializer
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
        setState(() => this._year = value);
      }
    });
  }
}
