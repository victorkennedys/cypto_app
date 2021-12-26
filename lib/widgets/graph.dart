import 'package:cypto_tracker_2/models/chart_model.dart';
import 'package:cypto_tracker_2/widgets/coin_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class CoinGraph extends StatelessWidget {
  final Function callback;
  final double min;
  final double max;
  final List<FlSpot> values;

  CoinGraph(this.callback, this.min, this.max, this.values);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(
              touchCallback: (event, touchResponse) {
                if (event is FlPanEndEvent) {
                  Future.delayed(Duration.zero, () async {
                    callback(0, 0);
                  });
                  // handle tap here
                }
                if (event is FlPanCancelEvent) {
                  Future.delayed(Duration.zero, () async {
                    callback(0, 0);
                  });
                  // handle tap here
                }
              },
              enabled: true,
              touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Colors.transparent,
                fitInsideHorizontally: true,
                getTooltipItems: (touchedSpots) {
                  Future.delayed(Duration.zero, () async {
                    callback(touchedSpots[0].y, touchedSpots[0].x);
                  });

                  return touchedSpots.map((LineBarSpot touchedSpot) {
                    final textStyle = TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    );

                    return LineTooltipItem(
                        touchedSpot.y.toStringAsFixed(0), textStyle);
                  }).toList();
                },
              ),
            ),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(
              show: false,
            ),
            minX: (DateTime.now().millisecondsSinceEpoch -
                    chartData[chartData.length - 1].date) /
                (1000 * 60 * 60),
            maxX: (DateTime.now().millisecondsSinceEpoch - chartData[1].date) /
                (1000 * 60 * 60),
            minY: min,
            maxY: max,
            titlesData: LineTitles.getTitleData(),
            lineBarsData: [
              LineChartBarData(
                spots: values,
                isCurved: true,
                colors: gradientColors,
                barWidth: 2,
                dotData: FlDotData(
                  show: false,
                ),
                belowBarData: BarAreaData(
                  show: true,
                  colors: gradientColors
                      .map((color) => color.withOpacity(0.3))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LineTitles {
  static getTitleData() => FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: false,
        reservedSize: 22,
        getTitles: (value) {
          switch (value.toInt()) {
            case 0:
              return DateFormat('kk:mm').format(nowInHour).toString();
            case 5:
              return DateFormat('kk:mm').format(inFiveHours).toString();
            case 10:
              return DateFormat('kk:mm').format(inTenHours).toString();
            case 15:
              return DateFormat('kk:mm').format(inFifteenHours).toString();
            case 20:
              return DateFormat('kk:mm').format(inTwentyHours).toString();
            case 24:
              return DateFormat('kk:mm').format(inTwentyHours).toString();
          }
          ;
          return "";
        },
        margin: 8,
      ),
      leftTitles: SideTitles(showTitles: false),
      rightTitles: SideTitles(showTitles: false),
      topTitles: SideTitles(showTitles: false));
}
