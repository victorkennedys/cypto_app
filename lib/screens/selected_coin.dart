import 'dart:convert';
import 'package:cypto_tracker_2/main.dart';
import 'package:flutter/material.dart';
import 'package:cypto_tracker_2/constants.dart';
import 'package:http/http.dart';
import '../models/chart_model.dart';
import '../widgets/graph.dart';
import 'package:fl_chart/fl_chart.dart';

import 'loading_screen.dart';

class CoinView extends StatefulWidget {
  final String id;
  final String name;
  final String symbol;
  final String imageUrl;
  final dynamic price;
  final dynamic change;
  final dynamic changePercentage;
  final Function getGraphData;
  final List<FlSpot> spotValues;
  final double minValue;
  final double maxValue;
  final DateTime selectedRange;

  CoinView(
      this.id,
      this.name,
      this.symbol,
      this.imageUrl,
      this.price,
      this.change,
      this.changePercentage,
      this.getGraphData,
      this.spotValues,
      this.minValue,
      this.maxValue,
      this.selectedRange);

  @override
  State<CoinView> createState() => _CoinViewState();
}

class _CoinViewState extends State<CoinView> {
  void changeRange(DateTime range) {
    widget.spotValues.clear();
    chartData.clear();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LoadingScreen(
              widget.id,
              widget.name,
              widget.symbol,
              widget.imageUrl,
              widget.price,
              widget.change,
              widget.changePercentage,
              range);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          },
        ),
        title: Text(
          "${widget.name}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ValueGraph(
              widget.spotValues,
              widget.minValue,
              widget.maxValue,
              widget.id,
              widget.name,
              widget.symbol,
              widget.imageUrl,
              widget.price,
              widget.change,
              widget.changePercentage),
          Row(
            children: [
              RangeSelector(
                  "3y",
                  changeRange,
                  threeYearAgo,
                  widget.selectedRange == threeYearAgo
                      ? Colors.white.withOpacity(0.2)
                      : Colors.transparent),
              RangeSelector(
                  "1y",
                  changeRange,
                  yearAgo,
                  widget.selectedRange == yearAgo
                      ? Colors.white.withOpacity(0.2)
                      : Colors.transparent),
              RangeSelector(
                  "6m",
                  changeRange,
                  sixMonthsAgo,
                  widget.selectedRange == sixMonthsAgo
                      ? Colors.white.withOpacity(0.2)
                      : Colors.transparent),
              RangeSelector(
                  "3m",
                  changeRange,
                  threeMonthsAgo,
                  widget.selectedRange == threeMonthsAgo
                      ? Colors.white.withOpacity(0.2)
                      : Colors.transparent),
              RangeSelector(
                  "1m",
                  changeRange,
                  monthAgo,
                  widget.selectedRange == monthAgo
                      ? Colors.white.withOpacity(0.2)
                      : Colors.transparent),
              RangeSelector(
                  "1w",
                  changeRange,
                  weekAgo,
                  widget.selectedRange == weekAgo
                      ? Colors.white.withOpacity(0.2)
                      : Colors.transparent),
              RangeSelector(
                  "1d",
                  changeRange,
                  yesterday,
                  widget.selectedRange == yesterday
                      ? Colors.white.withOpacity(0.2)
                      : Colors.transparent),
            ],
          )
          /* chartData[index].date,
          chartData[index].price, */
        ],
      ),
    );
  }
}

class RangeSelector extends StatelessWidget {
  final String text;
  final Function selectRange;
  final DateTime functionInput;
  final Color color;

  RangeSelector(this.text, this.selectRange, this.functionInput, this.color);
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FlatButton(
        color: color,
        child: Text(text),
        onPressed: () {
          selectRange(functionInput);
        },
      ),
    );
  }
}
