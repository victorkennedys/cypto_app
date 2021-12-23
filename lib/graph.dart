import 'package:cypto_tracker_2/chart_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class ValueGraph extends StatefulWidget {
  final List<FlSpot> dataList;
  final DateTime selectedRange;
  final double maxPrice;
  final double minPrice;

  ValueGraph(this.dataList, this.selectedRange, this.maxPrice, this.minPrice);
  @override
  _ValueGraphState createState() => _ValueGraphState();
}

DateTime selectedRange = DateTime.now();
double maxX = 24.76019055553479;
double maxY = 0;
double minY = 0;

class _ValueGraphState extends State<ValueGraph> {
  @override
  void initState() {
    selectedRange = widget.selectedRange;
    maxY = widget.maxPrice;
    minY = widget.minPrice;

    super.initState();
  }

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
              minX: (DateTime.now().millisecondsSinceEpoch -
                      chartData[chartData.length - 1].date) /
                  (1000 * 60 * 60),
              maxX:
                  (DateTime.now().millisecondsSinceEpoch - chartData[1].date) /
                      (1000 * 60 * 60),
              minY: minY * 0.9,
              maxY: maxY * 1.1,
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
