import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/leave_component/alert_dialogs.dart';
import 'package:timecapturesystem/components/leave_component/button_row.dart';
import 'package:timecapturesystem/components/leave_component/date_format.dart';
import 'package:timecapturesystem/components/leave_component/detail_row.dart';
import 'package:timecapturesystem/models/lms/day_amount.dart';
import 'package:timecapturesystem/models/lms/leave.dart';
import 'package:timecapturesystem/models/lms/leave_option.dart';

import 'package:timecapturesystem/models/lms/leave_response.dart';
import 'package:timecapturesystem/models/lms/leave_status.dart';
import 'package:timecapturesystem/services/LMS/leave_service.dart';
import 'package:timecapturesystem/services/LMS/leave_availability_service.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:timecapturesystem/view/lms/admin_leave/user_data.dart';

import '../check_leaves.dart';

class LeaveDetailsPage extends StatefulWidget {
  LeaveDetailsPage({this.item});
  final Leave item;

  @override
  _LeaveDetailsPageState createState() => _LeaveDetailsPageState();
}

class _LeaveDetailsPageState extends State<LeaveDetailsPage> {
  LeaveService _leaveService = LeaveService();

  DateToString date = DateToString();

  ShowAlertDialog _dialog = ShowAlertDialog();

  LeaveAvailabilityService _availabilityService = LeaveAvailabilityService();

  double _allowedDays;

  double _requestedDays;

  double _approvedDays;

  double _takenDays;

  double _availableDays;

  bool _dataAvailable = false;

  // @override
  // void initState() {
  //   userLeaveTypeData(
  //       widget.item.userId, EnumToString.convertToString(widget.item.type));
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      ///App Bar
      appBar: AppBar(
        title: Text(
          'Leave',
          style: TextStyle(color: Colors.black),
        ),
        leading: BackButton(
          color: Colors.black,
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
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        ///Profile image
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: UserProfileImage(
                              userId: widget.item.userId,
                              height: 60,
                              width: 60),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///User name
                            UserNameText(
                                userId: widget.item.userId, fontSize: 18),

                            //Requested date
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
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ///Leave type
                              Text(
                                EnumToString.convertToString(widget.item.type)
                                        .substring(0, 1) +
                                    EnumToString.convertToString(
                                            widget.item.type)
                                        .substring(1)
                                        .toLowerCase()
                                        .replaceAll('_', '\n'),
                                style: TextStyle(
                                  color: Colors.purple[900],
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              ///Icon
                              CircleAvatar(
                                child: CheckType(type: widget.item.type)
                                    .typeIcon(),
                                radius: 15,
                                backgroundColor:
                                    CheckStatus(status: widget.item.status)
                                        .statusColor(),
                                foregroundColor: Colors.white,
                              ),

                              ///Leave Status
                              Text(
                                EnumToString.convertToString(widget.item.status)
                                        .substring(0, 1) +
                                    EnumToString.convertToString(
                                            widget.item.status)
                                        .substring(1)
                                        .toLowerCase()
                                        .replaceAll('_', '\n'),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: CheckStatus(status: widget.item.status)
                                      .statusColor(),
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 19,
                                ),
                              ),
                            ],
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

                          ///Buttons
                          this.widget.item.status == LeaveStatus.REQUESTED
                              ? TwoButtonRow(
                                  title1: 'Accept',
                                  title2: 'Reject',
                                  onPressed1: () {
                                    this._dialog.showConfirmationDialog(
                                      title: 'Confirm',
                                      onPressedYes: () async {
                                        int code =
                                            await _leaveService.acceptOrReject(
                                                this.widget.item.id,
                                                'ACCEPTED',
                                                "");
                                        if (code == 200) {
                                          // Navigator.pushReplacementNamed(
                                          //     context, '/adminGetLeaves');
                                          // ModalRoute.withName(
                                          //     '/adminGetLeaves');
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  '/userLeave',
                                                  (Route<dynamic> route) =>
                                                      false);
                                        }
                                      },
                                      onPressedNo: () {
                                        Navigator.pop(context);
                                      },
                                      context: context,
                                      children: [Text('Accept this leave')],
                                    );
                                  },
                                  onPressed2: () async {
                                    String reason = "";
                                    this._dialog.showConfirmationDialog(
                                      title: 'Confirm',
                                      onPressedYes: () async {
                                        int code =
                                            await _leaveService.acceptOrReject(
                                                this.widget.item.id,
                                                'REJECTED',
                                                reason);
                                        if (code == 200) {
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  '/userLeave',
                                                  (Route<dynamic> route) =>
                                                      false);
                                        }
                                      },
                                      onPressedNo: () {
                                        Navigator.pop(context);
                                      },
                                      context: context,
                                      children: [
                                        Text('Reject this leave'),
                                        TextField(
                                            decoration: InputDecoration(
                                                // border: InputBorder.none,
                                                hintText: 'Reason'),
                                            maxLines: null,
                                            onChanged: (text) {
                                              setState(() {
                                                reason = text;
                                              });
                                            })
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
              )),
        ),
      ),
    );
  }

  List<charts.Series<DayAmount, String>> _createChartData() {
    final data = [
      new DayAmount(
          "Available", this._availableDays, charts.Color(r: 89, g: 255, b: 89)),
      new DayAmount("Requested", this._requestedDays,
          charts.Color(r: 89, g: 216, b: 255)),
      new DayAmount(
          "Approved", this._approvedDays, charts.Color(r: 255, g: 166, b: 89)),
      new DayAmount(
          "Taken", this._takenDays, charts.Color(r: 255, g: 89, b: 100)),
    ];

    return [
      new charts.Series<DayAmount, String>(
        id: 'dayAmount',
        domainFn: (DayAmount dayAmount, _) => dayAmount.dayCategory,
        measureFn: (DayAmount dayAmount, _) => dayAmount.days,
        colorFn: (DayAmount dayAmount, _) => dayAmount.color,
        // labelAccessorFn: (DayAmount dayAmount, _) =>
        //     '${dayAmount.dayCategory}\n${dayAmount.days}',
        data: data,
      )
    ];
  }

  void userLeaveTypeData(String userId, String type) async {
    var data = await _availabilityService.getAvailableData(userId, type);

    LeaveOption option = LeaveOption.fromJson(data);

    this._allowedDays = option.allowedDays;
    this._requestedDays = option.requestedDays;
    this._approvedDays = option.approvedDays;
    this._takenDays = option.takenDays;
    this._availableDays = this._allowedDays -
        (this._requestedDays + this._approvedDays + this._takenDays);
  }
}
