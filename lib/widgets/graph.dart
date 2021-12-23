import 'package:cypto_tracker_2/models/chart_model.dart';
import 'package:cypto_tracker_2/widgets/coin_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class ValueGraph extends StatelessWidget {
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
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CoinCard(id, name, symbol, imageUrl, price.toStringAsFixed(1),
              change, changePercentage),
        ),
        Container(
          height: 400,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: LineChart(
              LineChartData(
                minX: (DateTime.now().millisecondsSinceEpoch -
                        chartData[chartData.length - 1].date) /
                    (1000 * 60 * 60),
                maxX: (DateTime.now().millisecondsSinceEpoch -
                        chartData[1].date) /
                    (1000 * 60 * 60),
                minY: maxPrice,
                maxY: minPrice,
                titlesData: LineTitles.getTitleData(),
                lineBarsData: [
                  LineChartBarData(
                    spots: dataList,
                    isCurved: true,
                    barWidth: 5,
                    belowBarData: BarAreaData(
                      show: true,
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
