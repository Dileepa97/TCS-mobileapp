import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/leave_component/alert_dialogs.dart';
import 'package:timecapturesystem/components/leave_component/button_row.dart';
import 'package:timecapturesystem/components/leave_component/date_format.dart';
import 'package:timecapturesystem/components/leave_component/detail_row.dart';
import 'package:timecapturesystem/models/lms/day_amount.dart';
import 'package:timecapturesystem/models/lms/leave_option.dart';

import 'package:timecapturesystem/models/lms/leave_response.dart';
import 'package:timecapturesystem/models/lms/leave_status.dart';
import 'package:timecapturesystem/services/LMS/leave_service.dart';
import 'package:timecapturesystem/services/LMS/leave_availability_service.dart';

import 'package:charts_flutter/flutter.dart' as charts;

class LeaveDetailsPage extends StatefulWidget {
  LeaveDetailsPage({this.item});
  final LeaveResponse item;

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

  @override
  void initState() {
    userLeaveTypeData(widget.item.userId,
        EnumToString.convertToString(widget.item.leaveType));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.item.userId),
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
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 25.0,
                            backgroundImage: AssetImage('images/user.png'),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          child: VerticalDivider(
                            thickness: 1,
                            color: Colors.black12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    // Container(
                    //   height: 150.0,
                    //   child: Padding(
                    //       padding: const EdgeInsets.all(10.0),
                    //       child: DonutPieChart(
                    //         _createChartData(),
                    //         animate: true,
                    //       )),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DetailRow(
                              keyString: 'Leave Title',
                              valueString: this.widget.item.leaveTitle),
                          SizedBox(height: 5),
                          DetailRow(
                              keyString: 'Leave Type',
                              valueString: EnumToString.convertToString(
                                  this.widget.item.leaveType)),
                          SizedBox(height: 5),
                          DetailRow(
                              keyString: 'Leave Status',
                              valueString: EnumToString.convertToString(
                                  this.widget.item.leaveStatus)),
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
                                  date.stringDate(this.widget.item.reqDate)),
                          SizedBox(height: 5),
                          DetailRow(
                              keyString: 'Start Date',
                              valueString: date
                                  .stringDate(this.widget.item.leaveStartDate)),
                          SizedBox(height: 5),
                          DetailRow(
                              keyString: 'Start Day Option',
                              valueString: EnumToString.convertToString(
                                  this.widget.item.startDayMethod)),
                          SizedBox(height: 5),
                          this.widget.item.leaveEndDate != null
                              ? DetailRow(
                                  keyString: 'End Date',
                                  valueString: date.stringDate(
                                      this.widget.item.leaveEndDate))
                              : SizedBox(),
                          SizedBox(height: 5),
                          this.widget.item.leaveEndDate != null
                              ? DetailRow(
                                  keyString: 'End Day Option',
                                  valueString: EnumToString.convertToString(
                                      this.widget.item.endDayMethod))
                              : SizedBox(),
                          SizedBox(height: 5),
                          DetailRow(
                              keyString: 'Leave Days',
                              valueString:
                                  this.widget.item.leaveCount.toString()),
                          SizedBox(
                            height: 30,
                            child: Divider(
                              color: Colors.black12,
                              thickness: 1,
                            ),
                          ),
                          DetailRow(keyString: 'Description', valueString: ''),
                          Text(
                            this.widget.item.leaveDescription,
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
                          this.widget.item.leaveStatus == LeaveStatus.REQUESTED
                              ? TwoButtonRow(
                                  title1: 'Accept',
                                  title2: 'Reject',
                                  onPressed1: () {
                                    this._dialog.showConfirmationDialog(
                                      title: 'Confirm',
                                      onPressedYes: () async {
                                        int code =
                                            await _leaveService.acceptOrReject(
                                                this.widget.item.leaveId,
                                                'ACCEPTED');
                                        if (code == 202) {
                                          Navigator.pushNamed(
                                              context, '/allLeaves');
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
                                    this._dialog.showConfirmationDialog(
                                      title: 'Confirm',
                                      onPressedYes: () async {
                                        int code =
                                            await _leaveService.acceptOrReject(
                                                this.widget.item.leaveId,
                                                'REJECTED');
                                        if (code == 202) {
                                          Navigator.pushNamed(
                                              context, '/allLeaves');
                                        }
                                      },
                                      onPressedNo: () {
                                        Navigator.pop(context);
                                      },
                                      context: context,
                                      children: [Text('Accept this leave')],
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
