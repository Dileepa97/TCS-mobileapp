import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:timecapturesystem/components/leave_component/alert_dialogs.dart';
import 'package:timecapturesystem/components/leave_component/date_format.dart';
import 'package:timecapturesystem/components/leave_component/detail_row.dart';
import 'package:timecapturesystem/components/rounded_button.dart';
import 'package:timecapturesystem/models/lms/leave.dart';
import 'package:timecapturesystem/models/lms/leave_response.dart';
import 'package:timecapturesystem/models/lms/leave_status.dart';

import 'package:timecapturesystem/services/LMS/leave_service.dart';

import '../check_leaves.dart';

class UserLeaveDetailsPage extends StatefulWidget {
  UserLeaveDetailsPage({this.item});
  final Leave item;

  @override
  _UserLeaveDetailsPageState createState() => _UserLeaveDetailsPageState();
}

class _UserLeaveDetailsPageState extends State<UserLeaveDetailsPage> {
  LeaveService _leaveService = LeaveService();

  DateToString date = DateToString();

  ShowAlertDialog _dialog = ShowAlertDialog();

  bool _spin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      ///App Bar
      appBar: AppBar(
        title: Text(
          EnumToString.convertToString(widget.item.type).substring(0, 1) +
              EnumToString.convertToString(widget.item.type)
                  .substring(1)
                  .toLowerCase()
                  .replaceAll('_', ' ') +
              ' leave',
          style: TextStyle(
            color: Colors.purple[900],
            fontFamily: 'Source Sans Pro',
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: BackButton(
          color: Colors.purple[900],
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        elevation: 0,
      ),

      ///Body
      body: Center(
        child: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(5.0),
              child: Padding(
                padding: const EdgeInsets.all(26.0),
                child: Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ///Icon
                            CircleAvatar(
                              child:
                                  CheckType(type: widget.item.type).typeIcon(),
                              radius: 25,
                              backgroundColor:
                                  CheckStatus(status: widget.item.status)
                                      .statusColor(),
                              foregroundColor: Colors.white,
                            ),

                            SizedBox(
                              width: 10,
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ///Leave Status
                                Text(
                                  EnumToString.convertToString(
                                              widget.item.status)
                                          .substring(0, 1) +
                                      EnumToString.convertToString(
                                              widget.item.status)
                                          .substring(1)
                                          .toLowerCase()
                                          .replaceAll('_', ' '),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        CheckStatus(status: widget.item.status)
                                            .statusColor(),
                                    fontFamily: 'Source Sans Pro',
                                    fontSize: 19,
                                  ),
                                ),

                                ///Requested date
                                Text(
                                  'Requested date : ' +
                                      widget.item.reqDate
                                          .toIso8601String()
                                          .substring(0, 10),
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontFamily: 'Source Sans Pro',
                                  ),
                                ),

                                ///Requested time
                                Text(
                                  'Requested time : ' +
                                      widget.item.reqDate
                                          .toIso8601String()
                                          .substring(11, 16),
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontFamily: 'Source Sans Pro',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),

                        ///Title
                        Text(
                          this.widget.item.title,
                          style: TextStyle(
                            color: Colors.cyan[800],
                            fontFamily: 'Source Sans Pro',
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(
                          height: 20,
                          child: Divider(
                            color: Colors.black12,
                            thickness: 1,
                          ),
                        ),

                        ///Start date
                        DetailRow(
                          keyString: 'Start Date',
                          valueString: widget.item.startDate
                              .toIso8601String()
                              .substring(0, 10),
                        ),
                        SizedBox(height: 5),

                        ///Start day method
                        DetailRow(
                            keyString: 'Start Day Method',
                            valueString: EnumToString.convertToString(
                                        widget.item.startDayMethod)
                                    .substring(0, 1) +
                                EnumToString.convertToString(
                                        this.widget.item.startDayMethod)
                                    .substring(1)
                                    .toLowerCase()
                                    .replaceAll('_', ' ')),
                        SizedBox(height: 5),

                        ///End date
                        this.widget.item.endDate != null
                            ? DetailRow(
                                keyString: 'End Date',
                                valueString: widget.item.endDate
                                    .toIso8601String()
                                    .substring(0, 10))
                            : SizedBox(),
                        this.widget.item.endDate != null
                            ? SizedBox(height: 5)
                            : SizedBox(),

                        ///End day method
                        this.widget.item.endDate != null
                            ? DetailRow(
                                keyString: 'End Day Method',
                                valueString: EnumToString.convertToString(
                                            widget.item.endDayMethod)
                                        .substring(0, 1) +
                                    EnumToString.convertToString(
                                            this.widget.item.endDayMethod)
                                        .substring(1)
                                        .toLowerCase()
                                        .replaceAll('_', ' '))
                            : SizedBox(),
                        this.widget.item.endDate != null
                            ? SizedBox(height: 5)
                            : SizedBox(),

                        ///Leave days
                        DetailRow(
                            keyString: 'Leave Days',
                            valueString: this.widget.item.days.toString()),
                        SizedBox(height: 5),

                        ///Leave taken days
                        this.widget.item.takenDays != 0
                            ? DetailRow(
                                keyString: 'Taken Days',
                                valueString:
                                    this.widget.item.takenDays.toString())
                            : SizedBox(),

                        ///Description
                        this.widget.item.description != null &&
                                this.widget.item.description != ""
                            ? SizedBox(
                                height: 30,
                                child: Divider(
                                  color: Colors.black12,
                                  thickness: 1,
                                ),
                              )
                            : SizedBox(),
                        this.widget.item.description != null &&
                                this.widget.item.description != ""
                            ? DetailRow(
                                keyString: 'Description', valueString: '')
                            : SizedBox(),
                        this.widget.item.description != null &&
                                this.widget.item.description != ""
                            ? Text(
                                this.widget.item.description,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Source Sans Pro',
                                  color: Colors.blueGrey[600],
                                ),
                              )
                            : SizedBox(),

                        ///Reject reason
                        this.widget.item.rejectReason != null &&
                                this.widget.item.rejectReason != ""
                            ? SizedBox(
                                height: 30,
                                child: Divider(
                                  color: Colors.black12,
                                  thickness: 1,
                                ),
                              )
                            : SizedBox(),
                        this.widget.item.rejectReason != null &&
                                this.widget.item.rejectReason != ""
                            ? DetailRow(
                                keyString: 'Rejected Reason', valueString: '')
                            : SizedBox(),
                        this.widget.item.rejectReason != null &&
                                this.widget.item.rejectReason != ""
                            ? Text(
                                this.widget.item.rejectReason,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Source Sans Pro',
                                  color: Colors.blueGrey[600],
                                ),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 30,
                          child: Divider(
                            color: Colors.black12,
                            thickness: 1,
                          ),
                        ),

                        ///Button
                        this.widget.item.status == LeaveStatus.REQUESTED ||
                                this.widget.item.status == LeaveStatus.ACCEPTED
                            ? RoundedButton(
                                title: 'Cancel Leave',
                                color: Colors.redAccent,
                                onPressed: () {
                                  this._dialog.showConfirmationDialog(
                                    title: 'Confirm',
                                    onPressedYes: () async {
                                      //_spin = true;
                                      int code = await _leaveService
                                          .cancelLeave(this.widget.item.id);
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
                                      Text('Do you want to cancel this leave ?')
                                    ],
                                  );
                                },
                              )
                            : SizedBox(),
                      ],
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
