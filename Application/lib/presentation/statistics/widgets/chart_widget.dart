import 'dart:math';

import 'package:energy_panel/_all.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

enum ChartWidgetType { meter, inverter }

class ChartWidget extends StatelessWidget {
  final double width;
  final ChartWidgetType chartWidgetType;
  final ScrollController scrollController;

  const ChartWidget({required this.width, required this.chartWidgetType, required this.scrollController});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorsPalette.cardColor, borderRadius: BorderRadius.circular(4)),
      child: Column(children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, .2), style: BorderStyle.solid, width: 2),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          child: Text(
            textAlign: TextAlign.start,
            chartWidgetType == ChartWidgetType.inverter ? 'Graf proizvodnje' : 'Graf potrošnje',
            style: GoogleFonts.nunitoSans(
              fontSize: 17,
              color: ColorsPalette.whiteSmoke,
            ),
          ),
        ),
        Expanded(
            child: Center(
                child: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocBuilder<StatisticsBloc, StatisticsState>(
            builder: (context, state) {
              if (state.status == StatisticsStateStatus.submittingSuccess) {
                final spots = chartWidgetType == ChartWidgetType.meter ? state.model!.smaFlSpots : state.model!.inverterFlSpots;
                if (state.model!.chartType == 0) {
                  return SfCartesianChart(
                    zoomPanBehavior: ZoomPanBehavior(
                      enablePanning: true,
                      enableMouseWheelZooming: true,
                      enableDoubleTapZooming: true,
                    ),
                    onZoomStart: (zoomingArgs) {
                      scrollController.jumpTo(scrollController.position.maxScrollExtent);
                    },
                    palette: chartWidgetType == ChartWidgetType.meter
                        ? [
                            ColorsPalette.red,
                          ]
                        : [ColorsPalette.green],
                    series: <ChartSeries>[
                      // Renders spline chart
                      SplineSeries<Spots, DateTime>(
                        dataSource: spots.toList(),
                        xValueMapper: (Spots data, _) => data.date,
                        yValueMapper: (Spots data, _) => data.value.toInt(),
                      )
                    ],
                    primaryXAxis: DateTimeAxis(
                      intervalType: DateTimeIntervalType.hours,
                      interval: chartWidgetType == ChartWidgetType.meter ? 3 : 1,
                      dateFormat: DateFormat.Hm(),
                    ),
                    primaryYAxis: NumericAxis(
                      axisLabelFormatter: (value) {
                        return ChartAxisLabel('${value.text} W', GoogleFonts.nunitoSans());
                      },
                    ),
                  );
                } else if (state.model!.chartType == 1) {
                  return SfCartesianChart(
                    palette: chartWidgetType == ChartWidgetType.meter
                        ? [
                            ColorsPalette.red,
                          ]
                        : [ColorsPalette.green],
                    series: <ChartSeries>[
                      // Renders spline chart
                      ColumnSeries<Spots, DateTime>(
                        dataSource: spots.toList(),
                        xValueMapper: (Spots data, _) => data.date,
                        yValueMapper: (Spots data, _) => data.value / 1000.toInt(),
                      )
                    ],
                    primaryXAxis: DateTimeAxis(
                      intervalType: DateTimeIntervalType.days,
                      interval: 1,
                      dateFormat: DateFormat.MMMd('bs'),
                    ),
                    primaryYAxis: NumericAxis(
                      axisLabelFormatter: (value) {
                        return ChartAxisLabel('${value.text} kWh', GoogleFonts.nunitoSans());
                      },
                    ),
                  );
                } else {
                  return SfCartesianChart(
                    palette: chartWidgetType == ChartWidgetType.meter
                        ? [
                            ColorsPalette.red,
                          ]
                        : [ColorsPalette.green],
                    series: <ChartSeries>[
                      // Renders spline chart
                      ColumnSeries<Spots, DateTime>(
                        dataSource: spots.toList(),
                        xValueMapper: (Spots data, _) => data.date,
                        yValueMapper: (Spots data, _) => data.value / 1000.toInt(),
                      )
                    ],
                    primaryXAxis: DateTimeAxis(
                      intervalType: DateTimeIntervalType.months,
                      interval: 1,
                      dateFormat: DateFormat.MMM('bs'),
                    ),
                    primaryYAxis: NumericAxis(
                      axisLabelFormatter: (value) {
                        return ChartAxisLabel('${value.text} kWh', GoogleFonts.nunitoSans());
                      },
                    ),
                  );
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ))),
      ]),
    );
  }
}
