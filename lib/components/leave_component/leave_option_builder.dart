import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/lms/day_amount.dart';
import 'package:timecapturesystem/models/lms/leave_option.dart';
import 'package:timecapturesystem/models/lms/leave_type.dart';
import 'package:timecapturesystem/view/lms/check_leaves.dart';

import 'divider_box.dart';
import 'donut_pie_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class LeaveOptionBuilder extends StatelessWidget {
  const LeaveOptionBuilder({
    Key key,
    @required this.list,
    this.isHorizontal,
  }) : super(key: key);

  final List<LeaveOption> list;
  final bool isHorizontal;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: isHorizontal ? Axis.horizontal : Axis.vertical,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      ///Icon
                      CircleAvatar(
                        child: CheckType(type: list[index].type).typeIcon(),
                        radius: 14,
                        backgroundColor: Colors.purple[900],
                        foregroundColor: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),

                      ///Type text
                      Text(
                        EnumToString.convertToString(list[index].type)
                                .substring(0, 1) +
                            EnumToString.convertToString(list[index].type)
                                .substring(1)
                                .toLowerCase()
                                .replaceAll('_', ' '),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.purple[900],
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),

                ///pie chart
                Container(
                  height: 250.0,
                  width: isHorizontal ? 300 : double.infinity,
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
          );
        });
  }

  ///create chart data
  List<charts.Series<DayAmount, String>> _createChartData(LeaveOption option) {
    dynamic data;

    ///for extended_annual, extended_medical, and Lieu leaves
    if (option.type == LeaveType.EXTENDED_ANNUAL ||
        option.type == LeaveType.EXTENDED_MEDICAL ||
        option.type == LeaveType.LIEU) {
      double _availableDays = option.allowedDays -
          (option.approvedDays + option.requestedDays + option.takenDays);

      ///if available days exist
      if (_availableDays > 0) {
        data = [
          new DayAmount(
              "Available", _availableDays, charts.Color(r: 89, g: 255, b: 89)),
          new DayAmount("Requested", option.requestedDays,
              charts.Color(r: 89, g: 216, b: 255)),
          new DayAmount("Approved", option.approvedDays,
              charts.Color(r: 255, g: 166, b: 89)),
          new DayAmount(
              "Taken", option.takenDays, charts.Color(r: 255, g: 89, b: 100)),
        ];
      }

      ///if available days not exist
      else {
        data = [
          new DayAmount("Requested", option.requestedDays,
              charts.Color(r: 89, g: 216, b: 255)),
          new DayAmount("Approved", option.approvedDays,
              charts.Color(r: 255, g: 166, b: 89)),
          new DayAmount(
              "Taken", option.takenDays, charts.Color(r: 255, g: 89, b: 100)),
        ];
      }
    }

    ///for another leave types
    else {
      double _availableDays = option.allowedDays -
          (option.approvedDays + option.requestedDays + option.takenDays);

      data = [
        new DayAmount(
            "Available", _availableDays, charts.Color(r: 89, g: 255, b: 89)),
        new DayAmount("Requested", option.requestedDays,
            charts.Color(r: 89, g: 216, b: 255)),
        new DayAmount("Approved", option.approvedDays,
            charts.Color(r: 255, g: 166, b: 89)),
        new DayAmount(
            "Taken", option.takenDays, charts.Color(r: 255, g: 89, b: 100)),
      ];
    }

    ///build data
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
