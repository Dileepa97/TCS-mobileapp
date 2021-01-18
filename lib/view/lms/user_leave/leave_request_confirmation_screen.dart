import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:timecapturesystem/components/leave_component/alert_dialogs.dart';
import 'package:timecapturesystem/components/leave_component/button_row.dart';
import 'package:timecapturesystem/components/leave_component/date_format.dart';
import 'package:timecapturesystem/components/leave_component/detail_row.dart';
import 'package:timecapturesystem/components/leave_component/display_card.dart';
import 'package:timecapturesystem/components/leave_component/divider_box.dart';
import 'package:timecapturesystem/services/LMS/leave_service.dart';

class RequestConfirmationScreen extends StatefulWidget {
  final String userId;
  final String leaveType;
  final String leaveTitle;
  final String leaveDescription;
  final DateTime startDate;
  final String startDayMethod;
  final DateTime endDate;
  final String endDayMethod;

  const RequestConfirmationScreen(
      {Key key,
      this.userId,
      this.leaveType,
      this.leaveTitle,
      this.leaveDescription,
      this.startDate,
      this.startDayMethod,
      this.endDate,
      this.endDayMethod})
      : super(key: key);

  @override
  _RequestConfirmationScreenState createState() =>
      _RequestConfirmationScreenState();
}

class _RequestConfirmationScreenState extends State<RequestConfirmationScreen> {
  LeaveService _leaveService = LeaveService();
  bool _spin = false;
  DateToString _date = DateToString();
  ShowAlertDialog _alertDialog = ShowAlertDialog();
  String _startDate;
  String _endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Leave Request',
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _spin,
        child: Center(
          child: PageCard(
            child: Column(
              children: [
                Text(
                  'Confirm Request Details',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                DividerBox(),
                DetailRow(
                    keyString: 'Leave Type', valueString: widget.leaveType),
                SizedBox(height: 5),
                DetailRow(
                    keyString: 'Leave Title', valueString: widget.leaveTitle),
                SizedBox(height: 5),
                DetailRow(
                    keyString: 'Description',
                    valueString: widget.leaveDescription),
                SizedBox(height: 5),
                DetailRow(
                    keyString: 'Start Date',
                    valueString: _date.stringDate(widget.startDate)),
                SizedBox(height: 5),
                DetailRow(
                    keyString: 'Start Day Option',
                    valueString: widget.startDayMethod),
                SizedBox(height: 5),
                widget.endDate != null
                    ? DetailRow(
                        keyString: 'End Date',
                        valueString: _date.stringDate(widget.endDate))
                    : SizedBox(),
                SizedBox(height: 5),
                widget.endDate != null
                    ? DetailRow(
                        keyString: 'End Day Option',
                        valueString: widget.endDayMethod)
                    : SizedBox(),
                SizedBox(height: 5),
                DividerBox(),
                TwoButtonRow(
                  title1: 'Confirm',
                  title2: 'Change',
                  onPressed2: () {
                    Navigator.pop(context);
                  },
                  onPressed1: () async {
                    setState(() {
                      _spin = true;
                    });

                    this._startDate = widget.startDate.toIso8601String();
                    if (widget.endDate == null) {
                      this._endDate = "";
                    } else
                      this._endDate = widget.endDate.toIso8601String();

                    int code = await _leaveService.newLeave(
                        widget.leaveTitle,
                        widget.leaveType,
                        widget.leaveDescription,
                        this._startDate,
                        this._endDate,
                        widget.startDayMethod,
                        widget.endDayMethod,
                        widget.userId);

                    if (code == 1) {
                      setState(() {
                        _spin = false;
                      });
                      this._alertDialog.showAlertDialog(
                            context: context,
                            title: 'Request Created',
                            body: 'Your request submitted succesfully',
                            color: Colors.blueAccent,
                            onPressed: () {
                              Navigator.pushNamed(context, '/userLeave');
                            },
                          );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
