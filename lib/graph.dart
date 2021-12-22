import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class ValueGraph extends StatefulWidget {
  final List<FlSpot> dataList;
  final double minDate;
  final double maxDate;

  ValueGraph(this.dataList, this.minDate, this.maxDate);
  @override
  _ValueGraphState createState() => _ValueGraphState();
}

class _ValueGraphState extends State<ValueGraph> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: LineChart(
            LineChartData(
              minX: widget.minDate,
              maxX: widget.maxDate,
              minY: 0,
              maxY: 60000,
              lineBarsData: [
                LineChartBarData(spots: widget.dataList),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
