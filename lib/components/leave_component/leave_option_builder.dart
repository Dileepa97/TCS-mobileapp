import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/lms/day_amount.dart';
import 'package:timecapturesystem/models/lms/leave_option.dart';
import 'package:timecapturesystem/view/lms/check_leaves.dart';

import 'divider_box.dart';
import 'donut_pie_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class LeaveOptionBuilder extends StatelessWidget {
  const LeaveOptionBuilder({
    Key key,
    @required this.list,
  }) : super(key: key);

  final List<LeaveOption> list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black12,
                  width: 4.0,
                ),
              ),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///Leave type
                      Row(
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

                      GestureDetector(
                        child: Text(
                          'Request Leave',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/requestFirstScreen');
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
                    child: list[index].allowedDays != 0.0
                        ? DonutPieChart(
                            _createChartData(list[index]),
                            animate: true,
                          )
                        : Center(
                            child: Text(EnumToString.convertToString(
                                        list[index].type)
                                    .substring(0, 1) +
                                EnumToString.convertToString(list[index].type)
                                    .substring(1)
                                    .toLowerCase()
                                    .replaceAll('_', ' ') +
                                ' does not has any allowed leave yet.'),
                          ),
                  ),
                ),
              ],
            ),
          );
        });
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
