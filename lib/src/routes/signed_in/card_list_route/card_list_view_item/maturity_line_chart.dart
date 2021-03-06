import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:saraka/blocs.dart';
import 'package:saraka/constants.dart';

class MaturityLineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CardDetailBloc>(
      builder: (context, cardDetailBloc) => SizedBox(
            child: StreamBuilder<List<Study>>(
              stream: cardDetailBloc.studies,
              builder: (context, snapshot) => charts.LineChart(
                    <charts.Series<Study, int>>[
                      charts.Series(
                        id: "maturity",
                        domainFn: (_, i) => i,
                        measureFn: (study, _) => study.maturity * 100,
                        colorFn: (_, i) => charts.Color(
                              r: SarakaColors.lightRed.red,
                              g: SarakaColors.lightRed.green,
                              b: SarakaColors.lightRed.blue,
                              a: 31,
                            ),
                        data: snapshot.hasData
                            ? snapshot.requireData.reversed.toList()
                            : [],
                      ),
                    ],
                    animate: false,
                    primaryMeasureAxis: charts.NumericAxisSpec(
                      viewport: charts.NumericExtents(0, 100),
                      renderSpec: charts.NoneRenderSpec(),
                    ),
                    domainAxis: charts.NumericAxisSpec(
                      showAxisLine: false,
                      renderSpec: new charts.NoneRenderSpec(),
                    ),
                    defaultRenderer: charts.LineRendererConfig(
                      strokeWidthPx: 3,
                      radiusPx: 4.5,
                      includePoints: false,
                      roundEndCaps: true,
                    ),
                    defaultInteractions: false,
                    layoutConfig: charts.LayoutConfig(
                      leftMarginSpec: charts.MarginSpec.fixedPixel(0),
                      topMarginSpec: charts.MarginSpec.fixedPixel(0),
                      rightMarginSpec: charts.MarginSpec.fixedPixel(0),
                      bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
                    ),
                  ),
            ),
          ),
    );
  }
}
