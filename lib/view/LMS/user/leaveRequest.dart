import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:timecapturesystem/components/rounded_button.dart';
import 'package:timecapturesystem/models/leave/LeaveStatus.dart';
import 'package:timecapturesystem/services/leaveService.dart';
import 'package:timecapturesystem/view/LMS/component/convert.dart';
import 'package:timecapturesystem/view/LMS/component/customDropDown.dart';
import 'package:timecapturesystem/view/LMS/component/inputContainer.dart';
import 'package:timecapturesystem/view/LMS/component/inputDate.dart';
import 'package:timecapturesystem/view/LMS/component/inputTextField.dart';
import 'package:timecapturesystem/view/LMS/component/pageCard.dart';

class LeaveRequest extends StatefulWidget {
  @override
  _LeaveRequestState createState() => _LeaveRequestState();
}

class _LeaveRequestState extends State<LeaveRequest> {
  String _userID;
  String _leaveTitle;
  String _leaveType;
  String _leaveMethod;
  String _leaveDescription = "";

  DateTime _startDate;

  DateTime _endDate;

  double _noOfDays;

  bool _spin = false;
  final LeaveService _leaveService = LeaveService();

  List<String> _leaveTypes = [
    'No_Pay',
    'Sick',
    'Maternity',
    'Casual',
    'Annual'
  ];

  List<String> _leaveMethods = ['Half_Day', 'Full_Day', 'Multiple_Day'];

  int _dayDif() {
    return (_endDate.difference(_startDate)).inDays;
  }

  Widget _buildUserID() {
    return InputContainer(
      child: InputTextField(
        labelText: 'User ID (for testing)',
        onChanged: (text) {
          setState(() {
            _userID = text;
          });
        },
      ),
    );
  }

  Widget _buildTitle() {
    return InputContainer(
      child: InputTextField(
        labelText: 'Leave Title',
        onChanged: (text) {
          setState(() {
            _leaveTitle = text;
          });
        },
      ),
    );
  }

  Widget _buildDescription() {
    return InputContainer(
      child: InputTextField(
        maxLines: null,
        labelText: 'Leave Description (Optional)',
        onChanged: (text) {
          setState(() {
            _leaveDescription = text;
          });
        },
      ),
    );
  }

  Widget _buildLeaveType() {
    return InputContainer(
      child: CustomDropDown(
        keyString: 'Leave Type',
        item: _leaveType,
        items: _leaveTypes,
        onChanged: (String newValue) {
          setState(() {
            _leaveType = newValue;
          });
        },
      ),
    );
  }

  Widget _buildLeaveMethod() {
    return InputContainer(
      child: CustomDropDown(
        keyString: 'Leave Method',
        item: _leaveMethod,
        items: _leaveMethods,
        onChanged: (String newValue) {
          setState(() {
            _leaveMethod = newValue;
          });
        },
      ),
    );
  }

  Widget _buildStartDate() {
    return InputContainer(
      height: 45.0,
      child: InputDate(
        keyString: 'Leave Start Date : ',
        date: _startDate,
        onTap: () {
          showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                  initialEntryMode: DatePickerEntryMode.input)
              .then((datePicked) {
            setState(() {
              _startDate = datePicked;
            });
          });
        },
      ),
    );
  }

  Widget _buildEndDate() {
    if (_leaveMethod == 'Multiple_Day') {
      return InputContainer(
        height: 45.0,
        child: InputDate(
          keyString: 'Leave End Date : ',
          date: _endDate,
          onTap: () {
            showDatePicker(
                    context: context,
                    initialDate: _startDate.add(Duration(days: 1)),
                    firstDate: _startDate.add(Duration(days: 1)),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                    initialEntryMode: DatePickerEntryMode.input)
                .then((date) {
              setState(() {
                _endDate = date;
              });
            });
          },
        ),
      );
    } else
      return SizedBox(
        height: 0.0,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/userLeave');
          },
        ),
        title: Text(
          'Leave Request',
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _spin,
        child: PageCard(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Create New Leave',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
                child: Divider(
                  thickness: 1,
                ),
              ),
              _buildUserID(),
              _buildTitle(),
              _buildLeaveType(),
              _buildLeaveMethod(),
              _buildStartDate(),
              _buildEndDate(),
              _buildDescription(),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundedButton(
                    color: Colors.blueAccent[200],
                    title: 'Submit',
                    minWidth: 100.0,
                    onPressed: () async {
                      if (_userID == null) {
                        _showAlertDialog(
                            title: 'Something Missing !',
                            body: 'Enter User ID',
                            color: Colors.redAccent);
                      } else if (_leaveTitle == null) {
                        _showAlertDialog(
                            title: 'Something Missing !',
                            body: 'Enter Leave Title',
                            color: Colors.redAccent);
                      } else if (_leaveType == null) {
                        _showAlertDialog(
                            title: 'Something Missing !',
                            body: 'Select Leave Type',
                            color: Colors.redAccent);
                      } else if (_leaveMethod == null) {
                        _showAlertDialog(
                            title: 'Something Missing !',
                            body: 'Select Leave Method',
                            color: Colors.redAccent);
                      } else if (_startDate == null) {
                        _showAlertDialog(
                            title: 'Something Missing !',
                            body: 'Leave Start Date field is empty',
                            color: Colors.redAccent);
                      } else {
                        if (_leaveMethod == 'Multiple_Day') {
                          if (_endDate == null) {
                            _showAlertDialog(
                                title: 'Something Missing !',
                                body: 'Leave End Date field is empty',
                                color: Colors.redAccent);
                          } else
                            _noOfDays = _dayDif().toDouble() + 1.0;
                        } else if (_leaveMethod == 'Half_Day') {
                          _endDate = _startDate;
                          _noOfDays = 0.5;
                        } else {
                          _endDate = _startDate;
                          _noOfDays = 1.0;
                        }

                        _showMConfirmationDialog(
                            title: 'Confirm Submission',
                            children: [
                              Text('User ID : $_userID'),
                              Text('Leave Title : $_leaveTitle'),
                              Text('Leave Type : $_leaveType'),
                              Text('Leave Method : $_leaveMethod'),
                              Text('No of Days : $_noOfDays'),
                              Text(
                                  'Leave Start Date : ${Convert(date: _startDate).stringDate()}'),
                              Text(_leaveMethod == 'Multiple_Day'
                                  ? 'Leave End Date : ${Convert(date: _endDate).stringDate()}'
                                  : ''),
                              Text('Leave Description : $_leaveDescription'),
                            ],
                            onPressedYes: () async {
                              // setState(() {
                              //   spin = true;
                              // });

                              ///for testing-------------

                              print(_userID);
                              print(_leaveTitle);
                              print(_leaveType);
                              print(_leaveMethod);
                              print(_startDate);
                              print(_endDate);
                              print(_noOfDays);
                              print(_leaveDescription);

                              ///------------------------
                              ///

                              int code = await _leaveService.newLeave(
                                  _leaveTitle,
                                  _leaveType,
                                  _leaveDescription,
                                  _startDate,
                                  _endDate,
                                  _noOfDays,
                                  LeaveStatus.REQUESTED,
                                  _userID);

                              Navigator.pushNamed(context, '/leaveRequest');
                            },
                            onPressedNo: () {
                              Navigator.of(context).pop();
                            });

                        // if (code == 1) {
                        //   setState(() {
                        //     spin = false;
                        //   });
                        //   //_showMyDialog();
                        // } else if (code == 404) {
                        //   displayDialog(
                        //       context, "Error 404", "Content not found");
                        // } else {
                        //   displayDialog(context, "Unknown Error",
                        //       "An Unknown Error Occurred");
                        // }
                      }
                    },
                  ),
                  RoundedButton(
                    color: Colors.redAccent[200],
                    title: 'Clear',
                    minWidth: 100.0,
                    onPressed: () {
                      setState(() {
                        Navigator.pushNamed(context, '/leaveRequest');
                      });
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMConfirmationDialog(
      {String title, List<Widget> children, onPressedYes, onPressedNo}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: children,
            ),
          ),
          actions: <Widget>[
            FlatButton(
                child: Text(
                  'Yes',
                  style: TextStyle(color: Colors.blueAccent),
                ),
                onPressed: onPressedYes),
            FlatButton(
                child: Text(
                  'No',
                  style: TextStyle(color: Colors.redAccent),
                ),
                onPressed: onPressedYes),
          ],
        );
      },
    );
  }

  Future<void> _showAlertDialog(
      {String title, String body, Color color}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$title', style: TextStyle(color: color)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$body ', style: TextStyle(color: color)),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok', style: TextStyle(color: color)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

//TODO: validate user id using regex
//todo: check endDate > startDate
//todo: Validate other inputs: cannot be null
//todo: leave confirmation using password, confirmation alert
//todo: add: navigator to available leave page, leave reason/description
//todo: scroller capability
