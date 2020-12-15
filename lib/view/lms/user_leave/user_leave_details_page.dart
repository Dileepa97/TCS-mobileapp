import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:timecapturesystem/components/leave_component/alert_dialogs.dart';
import 'package:timecapturesystem/components/leave_component/date_format.dart';
import 'package:timecapturesystem/components/leave_component/detail_row.dart';
import 'package:timecapturesystem/components/rounded_button.dart';
import 'package:timecapturesystem/models/lms/leave_response.dart';
import 'package:timecapturesystem/models/lms/leave_status.dart';

import 'package:timecapturesystem/services/LMS/leave_service.dart';

class UserLeaveDetailsPage extends StatelessWidget {
  UserLeaveDetailsPage({this.item});
  LeaveService _leaveService = LeaveService();
  DateToString date = DateToString();
  ShowAlertDialog _dialog = ShowAlertDialog();
  bool _spin = false;
  final LeaveResponse item;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _spin,
      child: Scaffold(
        appBar: AppBar(
          title: Text(this.item.userId),
        ),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(5.0),
              child: Card(
                shadowColor: Colors.black54,
                color: Colors.white,
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DetailRow(
                                keyString: 'Leave Title',
                                valueString: this.item.leaveTitle),
                            SizedBox(height: 5),
                            DetailRow(
                                keyString: 'Leave Type',
                                valueString: EnumToString.convertToString(
                                    this.item.leaveType)),
                            SizedBox(height: 5),
                            DetailRow(
                                keyString: 'Leave Status',
                                valueString: EnumToString.convertToString(
                                    this.item.leaveStatus)),
                            SizedBox(
                              height: 30,
                              child: Divider(
                                color: Colors.black12,
                                thickness: 1,
                              ),
                            ),
                            DetailRow(
                                keyString: 'Request Date',
                                valueString:
                                    date.stringDate(this.item.reqDate)),
                            SizedBox(height: 5),
                            DetailRow(
                                keyString: 'Start Date',
                                valueString:
                                    date.stringDate(this.item.leaveStartDate)),
                            SizedBox(height: 5),
                            DetailRow(
                                keyString: 'Start Day Option',
                                valueString: EnumToString.convertToString(
                                    this.item.startDayMethod)),
                            SizedBox(height: 5),
                            this.item.leaveEndDate != null
                                ? DetailRow(
                                    keyString: 'End Date',
                                    valueString:
                                        date.stringDate(this.item.leaveEndDate))
                                : SizedBox(),
                            SizedBox(height: 5),
                            this.item.leaveEndDate != null
                                ? DetailRow(
                                    keyString: 'End Day Option',
                                    valueString: EnumToString.convertToString(
                                        this.item.endDayMethod))
                                : SizedBox(),
                            SizedBox(height: 5),
                            DetailRow(
                                keyString: 'Leave Days',
                                valueString: this.item.leaveCount.toString()),
                            SizedBox(
                              height: 30,
                              child: Divider(
                                color: Colors.black12,
                                thickness: 1,
                              ),
                            ),
                            DetailRow(
                                keyString: 'Description', valueString: ''),
                            Text(
                              this.item.leaveDescription,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              child: Divider(
                                color: Colors.black12,
                                thickness: 1,
                              ),
                            ),
                            this.item.leaveStatus == LeaveStatus.REQUESTED ||
                                    this.item.leaveStatus ==
                                        LeaveStatus.ACCEPTED
                                ? RoundedButton(
                                    title: 'Cancel Leave',
                                    color: Colors.redAccent,
                                    onPressed: () {
                                      this._dialog.showConfirmationDialog(
                                        title: 'Confirm',
                                        onPressedYes: () async {
                                          //_spin = true;
                                          int code = await _leaveService
                                              .cancelLeave(this.item.leaveId);
                                          if (code == 202) {
                                            //_spin = false;
                                            Navigator.pushNamed(
                                                context, '/ownLeave');
                                          }
                                        },
                                        onPressedNo: () {
                                          Navigator.pop(context);
                                        },
                                        context: context,
                                        children: [
                                          Text(
                                              'Do you want to cancel this leave ?')
                                        ],
                                      );
                                    },
                                  )
                                : SizedBox(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
