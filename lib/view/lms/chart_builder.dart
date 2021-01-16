import 'package:timecapturesystem/models/lms/day_amount.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartBuilder {
  double _availableDays;
  double _requestedDays;
  double _approvedDays;
  double _takenDays;

  ChartBuilder(
      {double availableDays,
      double requestedDays,
      double approvedDays,
      double takenDays}) {
    this._availableDays = availableDays;
    this._requestedDays = requestedDays;
    this._approvedDays = approvedDays;
    this._takenDays = takenDays;
  }

  List<charts.Series<DayAmount, String>> createChartData() {
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
}
