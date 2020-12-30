import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/leave_component/custom_drop_down.dart';
import 'package:timecapturesystem/components/leave_component/display_card.dart';
import 'package:timecapturesystem/components/leave_component/donut_pie_chart.dart';
import 'package:timecapturesystem/components/leave_component/input_container.dart';
import 'package:timecapturesystem/components/leave_component/input_text_field.dart';
import 'package:timecapturesystem/components/rounded_button.dart';
import 'package:timecapturesystem/models/lms/day_amount.dart';
import 'package:timecapturesystem/models/lms/leave_option.dart';

import 'package:timecapturesystem/services/lms/leave_availability_service.dart';

import '../chart_builder.dart';
import 'leave_request_main_screen.dart';

class FirstRequestScreen extends StatefulWidget {
  @override
  _FirstRequestScreenState createState() => _FirstRequestScreenState();
}

class _FirstRequestScreenState extends State<FirstRequestScreen> {
  String _userID;
  String _leaveType;

  double _allowedDays;
  double _requestedDays;
  double _approvedDays;
  double _takenDays;
  double _availableDays;
  bool _isLeaveType = false;
  bool _isExtended = false;

  LeaveAvailabilityService _availabilityService = LeaveAvailabilityService();

  List<String> _leaveTypes = [
    'MEDICAL',
    'MATERNITY',
    'PATERNITY',
    'CASUAL',
    'ANNUAL',
    'LIEU',
    'EXTENDED_ANNUAL',
    'EXTENDED_MEDICAL'
  ];

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
      body: Center(
        child: PageCard(
          child: Column(
            children: [
              Text(
                'Select Leave Type',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              _buildUserID(),
              _buildLeaveType(),
              SizedBox(
                height: 20,
                child: Divider(
                  thickness: 1,
                  //  color: Colors.blueAccent[100],
                ),
              ),
              Container(
                height: 250.0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: _isLeaveType
                      ? DonutPieChart(
                          ChartBuilder(
                                  availableDays: this._availableDays,
                                  requestedDays: this._requestedDays,
                                  approvedDays: this._approvedDays,
                                  takenDays: this._takenDays)
                              .createChartData(),
                          animate: true,
                        )
                      : Center(
                          child: Text(
                            'No data available to display.',
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: 20,
                child: Divider(
                  thickness: 1,
                  //  color: Colors.blueAccent[100],
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: _isExtended
                      ? RoundedButton(
                          color: Colors.blueAccent[200],
                          title: 'Create Request',
                          minWidth: 200.0,
                          onPressed: () {
                            setState(() {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return LeaveRequest(
                                    userID: this._userID,
                                    leaveType: this._leaveType,
                                    availableDays: this._availableDays);
                              }));
                            });
                          },
                        )
                      : Center(
                          child: Text(
                            'You have no any available leaves\nfor the leave type $_leaveType. \nTry another leave type',
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserID() {
    return InputContainer(
      child: InputTextField(
        labelText: 'User ID (for testing)',
        onChanged: (text) {
          setState(() {
            this._userID = text;
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
            this._leaveType = newValue;
            userLeaveTypeData(this._userID, this._leaveType);
          });
        },
      ),
    );
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

    setState(() {
      if (this._leaveType == 'LIEU' ||
          this._leaveType == 'EXTENDED_ANNUAL' ||
          this._leaveType == 'EXTENDED_MEDICAL') {
        // For LIEU, EXTENDED_ANNUAL, EXTENDED_MEDICAL leave types
        if (this._allowedDays == 0.0) {
          this._isLeaveType = false;
        } else
          this._isLeaveType = true;
        if (this._availableDays == 0.0) {
          this._isExtended = true;
        } else
          this._isExtended = true;
      } else {
        // For other leave types.
        this._isLeaveType = true;
        if (this._availableDays == 0.0) {
          this._isExtended = false;
        } else
          this._isExtended = true;
      }
    });
  }
}
