import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DonutPieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutPieChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(
      seriesList,
      animate: animate,
      defaultRenderer: new charts.ArcRendererConfig(
        arcWidth: 30,
        arcRendererDecorators: [
          // new charts.ArcLabelDecorator(
          //   showLeaderLines: false,
          //   outsideLabelStyleSpec: new charts.TextStyleSpec(fontSize: 12),
          //   // insideLabelStyleSpec: new charts.TextStyleSpec(fontSize: 18),
          //   labelPosition: charts.ArcLabelPosition.outside,
          // )
        ],
      ),
      behaviors: [
        // our title behaviour
        new charts.DatumLegend(
          position: charts.BehaviorPosition.bottom,
          outsideJustification: charts.OutsideJustification.middleDrawArea,
          horizontalFirst: false,
          cellPadding: new EdgeInsets.all(8.0),
          showMeasures: true,
          desiredMaxColumns: 2,
          desiredMaxRows: 2,
          legendDefaultMeasure: charts.LegendDefaultMeasure.firstValue,
          measureFormatter: (num value) {
            return value == null ? '0.0' : "$value";
          },
          entryTextStyle: charts.TextStyleSpec(
              color: charts.MaterialPalette.black, fontSize: 14),
        ),
      ],
    );
  }
}
