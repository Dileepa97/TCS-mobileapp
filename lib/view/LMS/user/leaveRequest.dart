import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:timecapturesystem/components/dialog_box.dart';
import 'package:timecapturesystem/models/leave/LeaveStatus.dart';
import 'package:timecapturesystem/services/leaveService.dart';
import 'package:timecapturesystem/models/leave/LeaveStatus.dart';

class LeaveRequest extends StatefulWidget {
  @override
  _LeaveRequestState createState() => _LeaveRequestState();
}

class _LeaveRequestState extends State<LeaveRequest> {
  final _formKey = GlobalKey<FormState>();

  String _userID;
  String _leaveType;
  String _leaveDescription = 'new leave';

  DateTime _startDate;
  int _startDay;
  int _startMonth;
  int _startYear;

  Duration _aDay = Duration(days: 1);
  DateTime _endDate;
  int _endDay;
  int _endMonth;
  int _endYear;
  int _noOfDays;

  bool spin = false;
  final LeaveService _leaveService = LeaveService();

  List<String> leaveTypes = ['No Pay', 'Maternity', 'Sick', 'Annual', 'Casual'];

  int _dayDif() {
    return (_endDate.difference(_startDate)).inDays;
  }

  Widget _buildUserID() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'User Id*',
        icon: Icon(
          Icons.person,
          color: Colors.blueAccent,
        ),
        border: OutlineInputBorder(),
      ),
      maxLength: 6,
      validator: (String value) {
        if (value.isEmpty) {
          return 'User Id is required';
        }
        return null;
      },
      onSaved: (String value) {
        _userID = value;
      },
    );
  }

  Widget _buildLeaveType() {
    return Row(
      children: [
        SizedBox(
          width: 40,
        ),
        Expanded(
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Leave Type :',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                DropdownButton<String>(
                  value: _leaveType,
                  hint: Text('Leave Type'),
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 24,

                  //elevation: 16,
                  underline: Container(
                    height: 2,
                    color: Colors.black54,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      _leaveType = newValue;
                    });
                  },
                  items:
                      leaveTypes.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStartDate() {
    return Row(
      children: [
        Icon(
          Icons.calendar_today,
          color: Colors.blueAccent,
        ),
        SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: Card(
            child: FlatButton(
              child: Text(
                _startDate == null
                    ? 'Leave Start Date'
                    : 'Start Date : $_startDay-$_startMonth-$_startYear',
              ),
              onPressed: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2021),
                        initialEntryMode: DatePickerEntryMode.input)
                    .then((date) {
                  setState(() {
                    _startDate = date;
                    _startDay = date.day;
                    _startMonth = date.month;
                    _startYear = date.year;
                  });
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEndDate() {
    return Row(
      children: [
        Icon(
          Icons.calendar_today,
          color: Colors.blueAccent,
        ),
        SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: Card(
            child: FlatButton(
              child: Text(
                _endDate == null
                    ? 'Leave End Date'
                    : 'End Date : $_endDay-$_endMonth-$_endYear',
              ),
              onPressed: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now().add(_aDay),
                        firstDate: _startDate,
                        lastDate: DateTime(2021),
                        initialEntryMode: DatePickerEntryMode.input)
                    .then((date) {
                  setState(() {
                    _endDate = date;
                    _endDay = date.day;
                    _endMonth = date.month;
                    _endYear = date.year;
                  });
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Leave Request',
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: spin,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildUserID(),
                    _buildLeaveType(),
                    _buildStartDate(),
                    _buildEndDate(),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          color: Colors.blueAccent[200],
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              if (_leaveType == null) {
                                _showMyDialog1(
                                    'Something Missing !', 'Select Leave Type');
                              } else if (_startDate == null) {
                                _showMyDialog1('Something Missing !',
                                    'Leave Start Date field is empty');
                              } else if (_endDate == null) {
                                _showMyDialog1('Something Missing !',
                                    'Leave End Date field is empty');
                              } else {
                                setState(() {
                                  spin = true;
                                });
                                _formKey.currentState.save();
                                _noOfDays = _dayDif();

                                int code = await _leaveService.newLeave(
                                    _leaveType,
                                    _leaveDescription,
                                    _startDate,
                                    _endDate,
                                    _noOfDays,
                                    LeaveStatus.REQUESTED,
                                    _userID);

                                if (code == 1) {
                                  setState(() {
                                    spin = false;
                                  });
                                  _showMyDialog();
                                } else if (code == 404) {
                                  displayDialog(context, "Error 404",
                                      "Content not found");
                                } else {
                                  displayDialog(context, "Unknown Error",
                                      "An Unknown Error Occurred");
                                }

                                ///for testing-------------

                                print(_userID);
                                print(_startDate);
                                print(_endDate);
                                print(_noOfDays);
                                print(_leaveType);

                                ///------------------------
                              }
                            }
                          },
                          child: Text('Submit'),
                        ),
                        RaisedButton(
                          color: Colors.red[400],
                          child: Text('Clear'),
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
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Leave Submitted'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Leave submitted successfully'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Done'),
              onPressed: () {
                Navigator.pushNamed(context, '/leaveRequest');
                //Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialog1(String title, String str) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$title', style: TextStyle(color: Colors.red)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$str ', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok', style: TextStyle(color: Colors.red)),
              onPressed: () {
                //Navigator.pushNamed(context, '/leaveRequest');
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
