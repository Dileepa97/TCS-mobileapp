import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/components/leave_component/alert_dialogs.dart';
import 'package:timecapturesystem/components/leave_component/custom_drop_down.dart';
import 'package:timecapturesystem/components/leave_component/divider_box.dart';
import 'package:timecapturesystem/models/lms/leave_day_allocation.dart';
import 'package:timecapturesystem/services/lms/leave_day_allocation_service.dart';
import 'package:timecapturesystem/view/lms/check_leaves.dart';

class ChangeAllowedDays extends StatefulWidget {
  static const String id = "change_allowed_day_screen";

  @override
  _ChangeAllowedDaysState createState() => _ChangeAllowedDaysState();
}

class _ChangeAllowedDaysState extends State<ChangeAllowedDays> {
  List<String> _leaveTypes = [
    'CASUAL',
    'ANNUAL',
    'MEDICAL',
    'EXTENDED_ANNUAL',
    'EXTENDED_MEDICAL',
    'LIEU',
    'MATERNITY',
    'PATERNITY',
  ];
  String leaveType = 'CASUAL';
  String days;

  LeaveDayAllocationService _allocationService = LeaveDayAllocationService();
  ShowAlertDialog _dialog = ShowAlertDialog();

  List<LeaveDayAllocation> _leaves;

  bool _spin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,

      ///app bar
      appBar: AppBar(
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
      body: ModalProgressHUD(
        inAsyncCall: _spin,
        child: SafeArea(
          child: Column(
            children: [
              ///title
              Text("Days allowed for leaves",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  )),

              ///allowed day display card
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),

                  ///allowed day list
                  child: FutureBuilder<dynamic>(
                    future: _allocationService.getAllLeaveAllocations(context),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      Widget child;
                      if (snapshot.hasData) {
                        if (snapshot.data == 204) {
                          child = Center(
                            child: Text(
                              "No leave allowed data to display",
                              textAlign: TextAlign.center,
                            ),
                          );
                        } else if (snapshot.data == 1) {
                          child = Center(
                            child: Text(
                              "An unknown error occured. \nPlease try again later",
                              textAlign: TextAlign.center,
                            ),
                          );
                        } else if (snapshot.data == -1) {
                          child = Center(
                            child: Text(
                              "Connection Error. \nPlease check your connection and try again later",
                              textAlign: TextAlign.center,
                            ),
                          );
                        } else {
                          _leaves = snapshot.data;

                          child = ListView.builder(
                            itemCount: _leaves.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 39,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ///type icon
                                        CheckType(type: _leaves[index].type)
                                            .typeIcon(),

                                        ///leave type
                                        Text(
                                          EnumToString.convertToString(
                                                      _leaves[index].type)
                                                  .substring(0, 1) +
                                              EnumToString.convertToString(
                                                      _leaves[index].type)
                                                  .substring(1)
                                                  .toLowerCase()
                                                  .replaceAll('_', ' '),
                                          style: TextStyle(
                                            fontFamily: 'Source Sans Pro',
                                            fontSize: 17,
                                          ),
                                        ),

                                        ///no of days
                                        Text(
                                          '${_leaves[index].allowedDays}',
                                          style: TextStyle(
                                            fontFamily: 'Source Sans Pro',
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      thickness: 1,
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      } else {
                        child = Center(
                            child: Text(
                          "Please wait...",
                          textAlign: TextAlign.center,
                        ));
                      }

                      return child;
                    },
                  ),
                ),
              ),

              ///change allowed days card
              Expanded(
                child: Container(
                  height: 200,
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),

                  ///change body
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ///card title
                        Text(
                          'Change allowed days',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Source Sans Pro',
                            color: Colors.blue[400],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        DividerBox(),

                        ///detail change row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ///type dropdown
                            CustomDropDown(
                              keyString: 'Leave Type',
                              item: this.leaveType,
                              items: this._leaveTypes,
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
                                  labelStyle:
                                      TextStyle(color: Colors.blue[700]),
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
                        SizedBox(
                          height: 10,
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

                            ///if input is acceptable
                            else {
                              setState(() {
                                _spin = true;
                              });

                              this._dialog.showConfirmationDialog(
                                    title: 'Confirm',
                                    context: context,
                                    children: [
                                      DateTime.now().month != 12
                                          ? Text(
                                              'By taking this action allowed leaves for selected leave type will change for every user in this year')
                                          : Text(
                                              'By taking this action allowed leaves for selected leave type will change for every user in this year and next year'),
                                    ],

                                    ///on pressed yes
                                    onPressedYes: () async {
                                      Navigator.pop(context);

                                      dynamic code = await _allocationService
                                          .changeAllowedDays(
                                              this.leaveType, this.days);

                                      ///if success
                                      if (code == 200) {
                                        _dialog.showAlertDialog(
                                          title: 'Allowed Days Changed',
                                          body:
                                              'Allowed days for leave type changed successfully',
                                          color: Colors.blueAccent,
                                          context: context,
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            setState(() {
                                              _spin = false;
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
                                      });
                                    },
                                  );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
