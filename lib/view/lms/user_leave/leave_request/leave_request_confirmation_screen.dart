import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/components/leave_component/alert_dialogs.dart';
import 'package:timecapturesystem/components/leave_component/button_row.dart';
import 'package:timecapturesystem/components/leave_component/detail_column.dart';

import 'package:timecapturesystem/components/leave_component/detail_row.dart';

import 'package:timecapturesystem/components/leave_component/divider_box.dart';

import 'package:timecapturesystem/services/LMS/leave_service.dart';
import 'package:timecapturesystem/view/lms/check_leaves.dart';

class RequestConfirmationScreen extends StatefulWidget {
  static const String id = "user_leave_request_confirmation_screen";

  final String userId;
  final String leaveType;
  final String leaveTitle;
  final String leaveDescription;
  final DateTime startDate;
  final String startDayMethod;
  final DateTime endDate;
  final String endDayMethod;
  final File file;
  final bool isFile;

  const RequestConfirmationScreen(
      {Key key,
      this.userId,
      this.leaveType,
      this.leaveTitle,
      this.leaveDescription,
      this.startDate,
      this.startDayMethod,
      this.endDate,
      this.endDayMethod,
      this.file,
      this.isFile})
      : super(key: key);

  @override
  _RequestConfirmationScreenState createState() =>
      _RequestConfirmationScreenState();
}

class _RequestConfirmationScreenState extends State<RequestConfirmationScreen> {
  LeaveService _leaveService = LeaveService();
  bool _spin = false;

  ShowAlertDialog _alertDialog = ShowAlertDialog();
  String _startDate;
  String _endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,

      ///app bar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue.shade800,
        title: Text(
          'Confirm your request',
          style: TextStyle(
            fontFamily: 'Source Sans Pro',
          ),
        ),
        centerTitle: true,
        actions: [
          HomeButton(),
        ],
      ),

      ///body
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: _spin,
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),

            //details
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ///leave title
                  DetailColumn(
                    keyString: 'Leave Title',
                    valueString: widget.leaveTitle,
                  ),
                  SizedBox(height: 20),

                  ///leave Description
                  widget.leaveDescription != ''
                      ? DetailColumn(
                          keyString: 'Leave Description',
                          valueString: widget.leaveDescription,
                        )
                      : SizedBox(),
                  SizedBox(height: 8),
                  DividerBox(),

                  ///leave type
                  DetailRow(
                    keyString: 'Leave Type',
                    valueString: widget.leaveType.substring(0, 1) +
                        widget.leaveType
                            .substring(1)
                            .toLowerCase()
                            .replaceAll('_', ' ') +
                        ' leave',
                  ),
                  SizedBox(height: 8),

                  ///start date
                  DetailRow(
                    keyString: 'Start Date',
                    valueString:
                        widget.startDate.toIso8601String().substring(0, 10),
                  ),
                  SizedBox(height: 8),

                  ///start day option
                  this.widget.leaveType == 'MATERNITY' ||
                          this.widget.leaveType == 'PATERNITY'
                      ? SizedBox()
                      : DetailRow(
                          keyString: 'Start Day Method',
                          valueString: widget.startDayMethod.substring(0, 1) +
                              widget.startDayMethod
                                  .substring(1)
                                  .toLowerCase()
                                  .replaceAll('_', ' '),
                        ),
                  SizedBox(height: 8),

                  //TODO: daycount from backend
                  ///end date for maternity
                  this.widget.leaveType == 'MATERNITY'
                      ? DetailRow(
                          keyString: 'End Date',
                          valueString: widget.startDate
                              .add(Duration(days: 179))
                              .toIso8601String()
                              .substring(0, 10),
                        )
                      : SizedBox(),

                  ///end date for paternity
                  this.widget.leaveType == 'PATERNITY'
                      ? DetailRow(
                          keyString: 'End Date',
                          valueString: widget.startDate
                              .add(Duration(days: 9))
                              .toIso8601String()
                              .substring(0, 10),
                        )
                      : SizedBox(),

                  ///end date
                  widget.endDate != null
                      ? DetailRow(
                          keyString: 'End Date',
                          valueString:
                              widget.endDate.toIso8601String().substring(0, 10),
                        )
                      : SizedBox(),
                  SizedBox(height: 8),

                  ///end day option
                  widget.endDate != null
                      ? DetailRow(
                          keyString: 'End Day Method',
                          valueString: widget.endDayMethod.substring(0, 1) +
                              widget.endDayMethod
                                  .substring(1)
                                  .toLowerCase()
                                  .replaceAll('_', ' '),
                        )
                      : SizedBox(),

                  ///Attachement
                  widget.isFile == true
                      ? Column(
                          children: [
                            DividerBox(),
                            DetailColumn(
                              keyString: 'Attachment',
                              valueString: widget.file.path.split('/').last,
                            ),
                          ],
                        )
                      : SizedBox(),

                  DividerBox(),

                  ///buttons
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

                      int code;
                      if (widget.isFile == true) {
                        code = await _leaveService.newLeaveWithAttachment(
                          widget.file,
                          widget.leaveTitle,
                          widget.leaveType,
                          widget.leaveDescription,
                          this._startDate,
                          this._endDate,
                          CheckMethod.convertMethodName(widget.startDayMethod),
                          CheckMethod.convertMethodName(widget.endDayMethod),
                        );
                      } else {
                        code = await _leaveService.newLeave(
                          widget.leaveTitle,
                          widget.leaveType,
                          widget.leaveDescription,
                          this._startDate,
                          this._endDate,
                          CheckMethod.convertMethodName(widget.startDayMethod),
                          CheckMethod.convertMethodName(widget.endDayMethod),
                        );
                      }

                      if (this.mounted) {
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
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                              );
                        } else {
                          setState(() {
                            _spin = false;
                          });
                          if (widget.isFile == true) {
                            this._alertDialog.showAlertDialog(
                                  context: context,
                                  title: 'Cannot Request',
                                  body:
                                      'There is an error. \nCheck your connection or attached file again (file size should be less than 2MB)',
                                  color: Colors.redAccent,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                );
                          } else {
                            this._alertDialog.showAlertDialog(
                                  context: context,
                                  title: 'Cannot Request',
                                  body: 'There is an error. \nTry again',
                                  color: Colors.redAccent,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                );
                          }
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
