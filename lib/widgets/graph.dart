import 'package:cypto_tracker_2/models/chart_model.dart';
import 'package:cypto_tracker_2/widgets/coin_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class ValueGraph extends StatefulWidget {
  final List<FlSpot> dataList;
  final double maxPrice;
  final double minPrice;
  final String id;
  final String name;
  final String symbol;
  final String imageUrl;
  final dynamic price;
  final dynamic change;
  final dynamic changePercentage;

  ValueGraph(
      this.dataList,
      this.maxPrice,
      this.minPrice,
      this.id,
      this.name,
      this.symbol,
      this.imageUrl,
      this.price,
      this.change,
      this.changePercentage);

  @override
  State<ValueGraph> createState() => _ValueGraphState();
}

class _ValueGraphState extends State<ValueGraph> {
  @override
  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors = [
      const Color(0xff23b6e6),
      const Color(0xff02d39a),
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CoinCard(
              widget.id,
              widget.name,
              widget.symbol,
              widget.imageUrl,
              widget.price.toStringAsFixed(1),
              widget.change,
              widget.changePercentage),
        ),
        Container(
          height: 400,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                  enabled: true,
                  touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: Colors.transparent,
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((LineBarSpot touchedSpot) {
                          final textStyle = TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          );

                          return LineTooltipItem(
                              touchedSpot.y.toStringAsFixed(0), textStyle);
                        }).toList();
                      }),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(
                  show: false,
                ),
                minX: (DateTime.now().millisecondsSinceEpoch -
                        chartData[chartData.length - 1].date) /
                    (1000 * 60 * 60),
                maxX: (DateTime.now().millisecondsSinceEpoch -
                        chartData[1].date) /
                    (1000 * 60 * 60),
                minY: widget.maxPrice,
                maxY: widget.minPrice,
                titlesData: LineTitles.getTitleData(),
                lineBarsData: [
                  LineChartBarData(
                    spots: widget.dataList,
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
        ),
      ],
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
