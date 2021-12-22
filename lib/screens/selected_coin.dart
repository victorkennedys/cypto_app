import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cypto_tracker_2/constants.dart';
import 'package:http/http.dart';
import 'chart_model.dart';
import '../graph.dart';
import 'package:fl_chart/fl_chart.dart';

class SelectedCoin extends StatefulWidget {
  final String name;
  final String symbol;
  final String imageUrl;
  final dynamic price;
  final dynamic change;
  final dynamic changePercentage;

  SelectedCoin(this.name, this.symbol, this.imageUrl, this.price, this.change,
      this.changePercentage);

  @override
  State<SelectedCoin> createState() => _SelectedCoinState();
}

class _SelectedCoinState extends State<SelectedCoin> {
  num minDate = 0;
  num maxDate = 0;
  DateTime selectedRange = DateTime.now();
  List<FlSpot> spotValues = [];

  void getGraphData(DateTime range) async {
    selectedRange = range;
    int date = range.toUtc().millisecondsSinceEpoch;
    int maxDate = (DateTime.now().toUtc()).millisecondsSinceEpoch;

    var data = await get(
      Uri.parse(
          "https://api.coingecko.com/api/v3/coins/bitcoin/market_chart/range?vs_currency=usd&from=${date.toInt() / 1000}&to=${maxDate.toInt() / 1000}"),
    );
    if (data.statusCode == 200) {
      List<dynamic> pricesList = jsonDecode(data.body)["prices"];

      var list = pricesList
          .map((e) => {"time": e[0], "value": e[1]})
          .toList(growable: true);

      for (Map i in list) {
        chartData.add(PriceData.fromJson(i));
        x();
      }
    }
  }

  void x() {
    for (int i = 0; i < chartData.length; i++) {
      var monthTime = chartData[i].date.toDouble() / 1000 / 60 / 60 / 24 / 365;
      setState(() {
        var spot = FlSpot(monthTime, chartData[i].price.toDouble());
        spotValues.add(spot);
        setMinValue();
      });
    }
  }

  void setMinValue() {
    var todayInSec = DateTime.now().millisecondsSinceEpoch / 1000;
    var selectedInSec = selectedRange.millisecondsSinceEpoch / 1000;
    setState(() {
      if (selectedRange == yesterday) {
        minDate = (todayInSec - selectedInSec) / (60 * 60);
        maxDate = todayInSec / (60 * 60);
      }
      if (selectedRange == weekAgo) {
        minDate = (todayInSec - selectedInSec) / (60 * 60 * 24 * 7);
        maxDate = todayInSec / (60 * 60 * 24 * 7);
      }
      if (selectedRange == monthAgo) {
        minDate = (todayInSec - selectedInSec) / (60 * 60 * 24 * 365) / 12;
        maxDate = todayInSec / (60 * 60 * 24 * 365) / 12;
      }
      if (selectedRange == threeMonthsAgo) {
        minDate = (todayInSec - selectedInSec) / (60 * 60 * 24 * 365);
        maxDate = todayInSec / (60 * 60 * 24 * 365) / 12;
      }
    });
  }

  @override
  void initState() {
    getGraphData(yesterday);

    super.initState();
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
          ValueGraph(spotValues, minDate.toDouble(), maxDate.toDouble()),
          Row(
            children: [
              RangeSelector("3y", getGraphData, threeYearAgo),
              RangeSelector("1y", getGraphData, yearAgo),
              RangeSelector("6m", getGraphData, sixMonthsAgo),
              RangeSelector("3m", getGraphData, threeMonthsAgo),
              RangeSelector("1m", getGraphData, monthAgo),
              RangeSelector("1w", getGraphData, weekAgo),
              RangeSelector("1d", getGraphData, yesterday),
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
