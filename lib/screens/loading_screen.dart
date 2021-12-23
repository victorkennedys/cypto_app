import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../chart_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'selected_coin.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  final String id;
  final String name;
  final String symbol;
  final String imageUrl;
  final dynamic price;
  final dynamic change;
  final dynamic changePercentage;
  final DateTime viewRange;

  LoadingScreen(this.id, this.name, this.symbol, this.imageUrl, this.price,
      this.change, this.changePercentage, this.viewRange);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  num minDate = 0;
  num maxDate = 0;
  DateTime selectedRange = DateTime.now();
  List<FlSpot> spotValues = [];
  String coinID = "";
  var maxValue;
  var minValue;

  void getGraphData(DateTime range) async {
    setState(() {
      selectedRange = range;
    });

    int date = range.millisecondsSinceEpoch;
    int maxDate = (DateTime.now()).millisecondsSinceEpoch;

    var data = await get(
      Uri.parse(
          "https://api.coingecko.com/api/v3/coins/$coinID/market_chart/range?vs_currency=usd&from=${date.toInt() / 1000}&to=${maxDate.toInt() / 1000}"),
    );

    if (data.statusCode == 200) {
      List<dynamic> pricesList = jsonDecode(data.body)["prices"];

      var list = pricesList
          .map((e) => {"time": e[0], "value": e[1]})
          .toList(growable: true);

      for (Map i in list) {
        chartData.add(PriceData.fromJson(i));
      }

      x();
    }
  }

  void x() async {
    for (int i = 0; i < chartData.length; i++) {
      double timeInSeconds = chartData[i].date.toDouble() / 1000;
      double timeInHours = timeInSeconds / 60 / 60;
      var h = (DateTime.now().millisecondsSinceEpoch) / 1000 / 60 / 60 -
          timeInHours;

      setState(() {
        var spot = FlSpot(h, chartData[i].price.toDouble());
        spotValues.add(spot);
      });
    }
    getMaxValue();
  }

  void getMaxValue() async {
    var largestValue = chartData[0].price;
    var smallestValue = chartData[0].price;
    for (int i = 0; i < chartData.length; i++) {
      if (chartData[i].price > largestValue) {
        largestValue = chartData[i].price;
      }

      if (chartData[i].price < smallestValue) {
        smallestValue = chartData[i].price;
      }
    }
    setState(() {
      minValue = smallestValue;
      maxValue = largestValue;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CoinView(
              widget.id,
              widget.name,
              widget.symbol,
              widget.imageUrl,
              widget.price,
              widget.change,
              widget.changePercentage,
              getGraphData,
              spotValues,
              minValue,
              maxValue);
        },
      ),
    );
  }

  @override
  void initState() {
    setState(() {
      coinID = widget.id;
      getGraphData(widget.viewRange);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitWanderingCubes(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
