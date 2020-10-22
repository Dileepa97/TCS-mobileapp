import 'package:flutter/material.dart';

class LeaveRequest extends StatefulWidget {
  @override
  _LeaveRequestState createState() => _LeaveRequestState();
}

class _LeaveRequestState extends State<LeaveRequest> {
  final _formKey = GlobalKey<FormState>();

  String _userID;
  String _leaveType;

  DateTime _startDate;
  int _startDay;
  int _startMonth;
  int _startYear;

  DateTime _endDate;
  int _endDay;
  int _endMonth;
  int _endYear;
  int _noOfDays;

  List<String> leaveTypes = ['No Pay', 'Maternity', 'Sick', 'Other'];

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
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
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
      body: Card(
        color: Colors.grey[300],
        borderOnForeground: true,
        margin: EdgeInsets.all(5.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
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
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          _noOfDays = _dayDif();

                          ///for testing-------------

                          print(_userID);
                          print(_startDate);
                          print(_endDate);
                          print(_noOfDays);
                          print(_leaveType);

                          ///------------------------
                        }
                      },
                      child: Text('Submit'),
                    ),
                    RaisedButton(
                      color: Colors.red[400],
                      child: Text('Clear'),
                      onPressed: () {
                        setState(() {
                          _userID = null;
                          _startDate = null;
                          _endDate = null;
                          _noOfDays = null;
                          _leaveType = null;
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
    );
  }
}

//TODO: validate user id using regex
//todo: check endDate > startDate
//todo: Validate other inputs: cannot be null
//todo: leave confirmation using password, confirmation alert
//todo: add: navigator to available leave page, leave reason/description
//todo: scroller capability
