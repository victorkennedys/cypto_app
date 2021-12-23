import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cypto_tracker_2/constants.dart';
import 'package:http/http.dart';
import '../chart_model.dart';
import '../graph.dart';
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
      this.maxValue);

  @override
  State<CoinView> createState() => _CoinViewState();
}

class _CoinViewState extends State<CoinView> {
  void changeRange(DateTime range) {
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
          ValueGraph(widget.spotValues, selectedRange, widget.minValue,
              widget.maxValue),
          Row(
            children: [
              RangeSelector("3y", changeRange, threeYearAgo),
              RangeSelector("1y", changeRange, yearAgo),
              RangeSelector("6m", changeRange, sixMonthsAgo),
              RangeSelector("3m", changeRange, threeMonthsAgo),
              RangeSelector("1m", changeRange, monthAgo),
              RangeSelector("1w", changeRange, weekAgo),
              RangeSelector("1d", changeRange, yesterday),
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

  RangeSelector(this.text, this.selectRange, this.functionInput);
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FlatButton(
        child: Text(text),
        onPressed: () {
          selectRange(functionInput);
        },
      ),
    );
  }
}
