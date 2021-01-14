import 'package:flutter/material.dart';

import 'package:timecapturesystem/components/leave_component/alert_dialogs.dart';
import 'package:timecapturesystem/components/leave_component/custom_drop_down.dart';
import 'package:timecapturesystem/components/leave_component/display_card.dart';
import 'package:timecapturesystem/components/leave_component/divider_box.dart';
import 'package:timecapturesystem/components/leave_component/input_container.dart';
import 'package:timecapturesystem/components/leave_component/input_date.dart';
import 'package:timecapturesystem/components/leave_component/input_text_field.dart';
import 'package:timecapturesystem/components/rounded_button.dart';

import 'leave_request_confirmation_screen.dart';

class LeaveRequest extends StatefulWidget {
  final String userID;
  final String leaveType;
  final double availableDays;

  const LeaveRequest({Key key, this.userID, this.leaveType, this.availableDays})
      : super(key: key);

  @override
  _LeaveRequestState createState() => _LeaveRequestState();
}

class _LeaveRequestState extends State<LeaveRequest> {
  String _leaveTitle;
  String _leaveDescription = "";

  bool _multiDayLeave = false;

  DateTime _startDate;
  DateTime _endDate;

  String _startDayMethod;
  String _endDayMethod;

  List<String> _leaveMethod1 = ['FIRST_HALF', 'SECOND_HALF', 'FULL'];
  List<String> _leaveMethod2 = ['SECOND_HALF', 'FULL'];
  List<String> _leaveMethod3 = ['FIRST_HALF', 'FULL'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Leave Request',
        ),
      ),
      body: PageCard(
        child: Column(
          children: [
            Text(
              'Create New Leave',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            DividerBox(),
            _buildTitle(),
            _buildDescription(),
            DividerBox(),
            _buildCheckBox(),
            _buildStartDate(),
            _buildStartDayMethod(),
            DividerBox(),
            _buildEndDate(),
            _buildEndDayMethod(),
            RoundedButton(
              color: Colors.blueAccent[200],
              title: 'Request',
              minWidth: 200.0,
              onPressed: () async {
                if (_checkCondition()) {
                  if (this._multiDayLeave == false) {
                    //this._endDate = this._startDate;
                    this._endDayMethod = 'NO';
                  }
                  // print(widget.userID);
                  // print(widget.availableDays);
                  // print(widget.leaveType);
                  // print(_leaveTitle);
                  // print(_leaveDescription);
                  // print(_startDate);
                  // print(_startDayMethod);
                  // print(_endDate);
                  // print(_endDayMethod);

                  setState(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return RequestConfirmationScreen(
                          userId: widget.userID,
                          leaveType: widget.leaveType,
                          leaveTitle: this._leaveTitle,
                          leaveDescription: this._leaveDescription,
                          startDate: this._startDate,
                          startDayMethod: this._startDayMethod,
                          endDate: this._endDate,
                          endDayMethod: this._endDayMethod);
                    }));
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

//todo: refactor this
  bool _checkCondition() {
    ShowAlertDialog check = ShowAlertDialog();

    if (this._leaveTitle == null) {
      check.showAlertDialog(
        title: 'Something Missing !',
        body: 'Enter leave title',
        color: Colors.redAccent,
        context: context,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      return false;
    } else if (this._startDate == null) {
      check.showAlertDialog(
        title: 'Something Missing !',
        body: 'Select leave start date',
        color: Colors.redAccent,
        context: context,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      return false;
    } else if (this._startDayMethod == null) {
      check.showAlertDialog(
        title: 'Something Missing !',
        body: 'Select leave start day option',
        color: Colors.redAccent,
        context: context,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      return false;
    } else if (this._multiDayLeave == true) {
      if (_endDate == null) {
        check.showAlertDialog(
          title: 'Something Missing !',
          body: 'Select leave end date',
          color: Colors.redAccent,
          context: context,
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
        return false;
      } else if (this._endDayMethod == null) {
        check.showAlertDialog(
          title: 'Something Missing !',
          body: 'Select leave end day option',
          color: Colors.redAccent,
          context: context,
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
        return false;
      }
    }
    return true;
  }

  Widget _buildCheckBox() {
    return Row(
      children: [
        Text('Multiple Day leaves : '),
        Checkbox(
          value: this._multiDayLeave,
          onChanged: (bool value) {
            setState(() {
              this._multiDayLeave = value;
              this._startDayMethod = null;
              this._endDayMethod = null;
              this._endDate = null;
            });
          },
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return InputContainer(
      child: InputTextField(
        labelText: 'Leave Title',
        onChanged: (text) {
          setState(() {
            this._leaveTitle = text;
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
            this._leaveDescription = text;
          });
        },
      ),
    );
  }

  Widget _buildStartDayMethod() {
    return InputContainer(
      child: CustomDropDown(
        keyString: 'Start Day Option',
        item: this._startDayMethod,
        items: this._multiDayLeave ? this._leaveMethod2 : this._leaveMethod1,
        onChanged: (String value) {
          setState(() {
            this._startDayMethod = value;
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
        date: this._startDate,
        onTap: () {
          showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                  initialEntryMode: DatePickerEntryMode.input)
              .then((datePicked) {
            setState(() {
              this._startDate = datePicked;
            });
          });
        },
      ),
    );
  }

  Widget _buildEndDate() {
    if (this._multiDayLeave) {
      return InputContainer(
        height: 45.0,
        child: InputDate(
          keyString: 'Leave End Date : ',
          date: this._endDate,
          onTap: () {
            showDatePicker(
                    context: context,
                    initialDate: this._startDate.add(Duration(days: 1)),
                    firstDate: this._startDate.add(Duration(days: 1)),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                    initialEntryMode: DatePickerEntryMode.input)
                .then((date) {
              setState(() {
                this._endDate = date;
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

  Widget _buildEndDayMethod() {
    if (this._multiDayLeave) {
      return InputContainer(
        child: CustomDropDown(
          keyString: 'End Day Option',
          item: this._endDayMethod,
          items: this._multiDayLeave ? this._leaveMethod3 : this._leaveMethod1,
          onChanged: (String value) {
            setState(() {
              this._endDayMethod = value;
            });
          },
        ),
      );
    } else
      return SizedBox(
        height: 0.0,
      );
  }
}
