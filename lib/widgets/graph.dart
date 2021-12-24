import 'package:cypto_tracker_2/models/chart_model.dart';
import 'package:cypto_tracker_2/widgets/coin_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

/* class Graph extends StatefulWidget {
  Graph(this.maxPrice, this.minPrice, this.dataList, this.gradientColors,
      this.callback);

  final double maxPrice;
  final double minPrice;
  final List<FlSpot> dataList;
  final List<Color> gradientColors;
  Function callback;

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  @override
  Widget build(BuildContext context) {
/* minPrice == null ?  */

    return 
  }
} */

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
