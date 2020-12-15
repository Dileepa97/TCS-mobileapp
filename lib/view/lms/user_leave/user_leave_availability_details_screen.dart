import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/leave_component/divider_box.dart';
import 'package:timecapturesystem/components/leave_component/donut_pie_chart.dart';
import 'package:timecapturesystem/models/lms/day_amount.dart';
import 'package:timecapturesystem/models/lms/leave_option.dart';

import 'package:timecapturesystem/services/LMS/leave_availability_service.dart';

import 'package:charts_flutter/flutter.dart' as charts;

class UserLeaveAvailable extends StatefulWidget {
  final List<LeaveOption> list;

  const UserLeaveAvailable({Key key, this.list}) : super(key: key);
  @override
  _UserLeaveAvailableState createState() => _UserLeaveAvailableState();
}

class _UserLeaveAvailableState extends State<UserLeaveAvailable> {
  double _allowedDays;
  double _requestedDays;
  double _approvedDays;
  double _takenDays;
  double _availableDays;
  bool _dataAvailable = false;
  LeaveAvailabilityService _availabilityService = LeaveAvailabilityService();
  List<LeaveOption> list = List<LeaveOption>();
  //LeaveOption item ;

  @override
  void initState() {
    // TODO: implement initState
    data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   data();
    // });
    // print(widget.list[0].type);
    //LeaveOption op = widget.list[1];
    return Scaffold(
      appBar: AppBar(
        title: Text('My Leave availability'),
        leading: BackButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/userLeave');
          },
        ),
      ),
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: _dataAvailable
                  ? Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  EnumToString.convertToString(
                                      list[index].type),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  child: Text('Request Leave'),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/requestFirstScreen');
                                  },
                                ),
                              ],
                            ),
                          ),
                          DividerBox(),
                          Container(
                            height: 250.0,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: DonutPieChart(
                                _createChartData(list[index]),
                                animate: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            );
          }),
    );
  }

  void data() async {
    var data =
        await _availabilityService.getUserLeaveAvailableData("U002") as List;
    //print(data);
    List<LeaveOption> arr = data
        .map((leaveResponseJson) => LeaveOption.fromJson(leaveResponseJson))
        .toList();

    //arr.sort((b, a) => a.reqDate.compareTo(b.reqDate));

    if (this.mounted) {
      setState(() {
        list = arr;
        // this._spin = false;
        this._dataAvailable = true;
      });
    }
  }

  List<charts.Series<DayAmount, String>> _createChartData(LeaveOption option) {
    double _availableDays = option.allowedDays -
        (option.approvedDays + option.requestedDays + option.takenDays);
    final data = [
      new DayAmount(
          "Available", _availableDays, charts.Color(r: 89, g: 255, b: 89)),
      new DayAmount("Requested", option.requestedDays,
          charts.Color(r: 89, g: 216, b: 255)),
      new DayAmount(
          "Approved", option.approvedDays, charts.Color(r: 255, g: 166, b: 89)),
      new DayAmount(
          "Taken", option.takenDays, charts.Color(r: 255, g: 89, b: 100)),
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
}
