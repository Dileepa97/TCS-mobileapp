import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/components/leave_component/alert_dialogs.dart';
import 'package:timecapturesystem/components/leave_component/custom_drop_down.dart';
import 'package:timecapturesystem/components/leave_component/divider_box.dart';
import 'package:timecapturesystem/components/leave_component/error_texts.dart';
import 'package:timecapturesystem/components/leave_component/leave_option_builder.dart';
import 'package:timecapturesystem/components/leave_component/leave_user_data_builders.dart';
import 'package:timecapturesystem/models/lms/leave_availability_detail.dart';
import 'package:timecapturesystem/models/lms/leave_option.dart';

import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/services/lms/leave_availability_service.dart';
import 'package:timecapturesystem/services/lms/leave_day_allocation_service.dart';

import 'package:timecapturesystem/services/user/user_service.dart';
import 'package:timecapturesystem/view/lms/admin_leave/admin_user_leave_list_screen.dart';

class MoreLeaveDetails extends StatefulWidget {
  static const String id = "more_leave_detail_screen";

  final String userId;

  const MoreLeaveDetails({Key key, this.userId}) : super(key: key);
  @override
  _MoreLeaveDetailsState createState() => _MoreLeaveDetailsState();
}

class _MoreLeaveDetailsState extends State<MoreLeaveDetails> {
  LeaveAvailabilityService _availabilityService = LeaveAvailabilityService();
  LeaveDayAllocationService _allocationService = LeaveDayAllocationService();

  int _year = DateTime.now().year;

  List<LeaveOption> _list = List<LeaveOption>();
  LeaveAvailabilityDetail _availabiltyData;

  ShowAlertDialog _dialog = ShowAlertDialog();

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

  String leaveType = 'CASUAL';
  String days;

  bool _spin = false;

  User _user;
  String _gender = 'Male';

  String _availabilityDataId;

  ///get logged in user data
  void getUser() async {
    _user = await UserService.getUserById(widget.userId);
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

      ///App_bar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue.shade800,
        actions: [
          ///on refresh
          GestureDetector(
            child: Icon(
              Icons.refresh,
            ),
            onTap: () {
              if (_list != null) {
                setState(() {
                  _list.removeRange(0, _list.length);
                  _year = DateTime.now().year;
                });
              } else {
                setState(() {
                  _year = DateTime.now().year;
                });
              }
            },
          ),
          HomeButton(),
        ],
      ),

      ///body
      body: ModalProgressHUD(
        inAsyncCall: _spin,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ///user details -----------------------------------------------------------------
              Container(
                margin: EdgeInsets.all(5),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ///uder profile image
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: UserProfileImage(
                          userId: widget.userId, height: 40, width: 40),
                    ),

                    ///user name
                    UserNameText(userId: widget.userId, fontSize: 18),
                    DividerBox(),

                    ///user leaves
                    GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 3),
                        decoration: BoxDecoration(
                          border: Border.all(width: 2.0, color: Colors.blue),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          color: Colors.white,
                        ),
                        child: Text(
                          'User Leaves',
                          style: TextStyle(
                            color: Colors.blue,
                            fontFamily: 'Source Sans Pro',
                            fontSize: 16,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminUserLeaveListScreen(
                              userId: this.widget.userId,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
              DividerBox(),

              ///availability details title ----------------------------------------------------
              Text(
                "Leave Availability Details",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),

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
                        _showIntDialog(DateTime.now().year - 1,
                            DateTime.now().year, _year);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),

              ///chart builder
              Container(
                height: 350,
                child: FutureBuilder<dynamic>(
                  future: _availabilityService.getUserLeaveAvailability(
                      context, this.widget.userId, _year),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    Widget child;
                    if (snapshot.hasData) {
                      if (snapshot.data == 204) {
                        child = CustomErrorText(
                            text:
                                "No leave availability data available for this year");
                      } else if (snapshot.data == 1) {
                        child = ServerErrorText();
                      } else if (snapshot.data == -1) {
                        child = ConnectionErrorText();
                      } else {
                        _availabiltyData = snapshot.data;
                        _list = _availabiltyData.leaveOptionList;

                        if (_availabiltyData.year == DateTime.now().year) {
                          _availabilityDataId = _availabiltyData.id;
                        }

                        child = LeaveOptionBuilder(
                          list: _list,
                          isHorizontal: true,
                        );
                      }
                    } else {
                      child = LoadingText();
                    }

                    return child;
                  },
                ),
              ),
              DividerBox(),

              ///change allowed days title----------------------------------------------------------------
              Text(
                'Change User Allowed Days',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),

              ///change allowed days card
              Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),

                ///change body
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ///detail change row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ///type dropdown
                          CustomDropDown(
                            keyString: 'Leave Type',
                            item: this.leaveType,
                            items: this._gender == 'Male'
                                ? this._leaveTypelistMale
                                : this._leaveTypelistFemale,
                            onChanged: (String newValue) {
                              setState(() {
                                this.leaveType = newValue;
                              });
                            },
                          ),

                          ///day input field
                          Container(
                            width: 100,
                            height: 30,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "Days",
                                labelStyle: TextStyle(color: Colors.blue[700]),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue[700],
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  this.days = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      ///button
                      FlatButton(
                        color: Colors.blue[500],
                        child: Text(
                          'Change',
                          style: TextStyle(color: Colors.white),
                        ),
                        minWidth: 100.0,

                        ///onpressed change
                        onPressed: () {
                          //if taken days field is empty
                          if (days == null || days.trim() == '') {
                            _dialog.showAlertDialog(
                              title: 'Something Missing !',
                              body: 'Please enter number of days',
                              color: Colors.redAccent,
                              context: context,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            );
                          }

                          ///if input is not valid
                          else if (double.tryParse(days) == null) {
                            _dialog.showAlertDialog(
                              title: 'Invalid Input !',
                              body: 'Please enter valid number',
                              color: Colors.redAccent,
                              context: context,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            );
                          }

                          ///if input is negative
                          else if (double.tryParse(days).isNegative) {
                            _dialog.showAlertDialog(
                              title: 'Invalid Input !',
                              body:
                                  'Entered number of allowed days cannot be negative',
                              color: Colors.redAccent,
                              context: context,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            );
                          }

                          //if taken days field is empty
                          else if (_availabilityDataId == null ||
                              _availabilityDataId.trim() == '') {
                            _dialog.showAlertDialog(
                              title: 'Something Missing !',
                              body:
                                  'To get leave availability id please check your connection and refresh the page.',
                              color: Colors.redAccent,
                              context: context,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            );
                          }

                          ///if input is acceptable
                          else {
                            setState(() {
                              _spin = true;
                            });

                            this._dialog.showConfirmationDialog(
                                  title: 'Confirm',
                                  context: context,
                                  children: [
                                    Text(
                                        'Do you want to change this user leave allowed data for selected leave type?'),
                                  ],

                                  ///on pressed yes
                                  onPressedYes: () async {
                                    Navigator.pop(context);

                                    dynamic code = await _allocationService
                                        .changeSingleAllowedDays(
                                            this._availabilityDataId,
                                            this.leaveType,
                                            this.days);

                                    ///if success
                                    if (code == 200) {
                                      _dialog.showAlertDialog(
                                        title: 'Allowed Days Changed',
                                        body:
                                            'Allowed days for this user and selected leave type changed successfully',
                                        color: Colors.blueAccent,
                                        context: context,
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          setState(() {
                                            _spin = false;
                                            _year = DateTime.now().year;
                                          });
                                        },
                                      );
                                    }

                                    ///if error
                                    else {
                                      _dialog.showAlertDialog(
                                        title: 'Error',
                                        body:
                                            'Cannot change allowed days now. \nTry again later',
                                        color: Colors.redAccent,
                                        context: context,
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          setState(() {
                                            _spin = false;
                                            _year = DateTime.now().year;
                                          });
                                        },
                                      );
                                    }
                                  },

                                  ///on pressed no
                                  onPressedNo: () {
                                    Navigator.pop(context);
                                    setState(() {
                                      _spin = false;
                                      _year = DateTime.now().year;
                                    });
                                  },
                                );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
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
