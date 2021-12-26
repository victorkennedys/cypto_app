import 'dart:convert';
import 'package:cypto_tracker_2/models/article_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../models/chart_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'selected_coin.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cypto_tracker_2/constants.dart';

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
  var livePrice;

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

      var todayPrice = await get(
        Uri.parse(
            "https://api.coingecko.com/api/v3/coins/$coinID/market_chart/range?vs_currency=usd&from=${yesterday.millisecondsSinceEpoch.toInt() / 1000}&to=${maxDate.toInt() / 1000}"),
      );
      List<dynamic> todayList = jsonDecode(todayPrice.body)["prices"];
      var alteredList = todayList
          .map((e) => {"time": e[0], "value": e[1]})
          .toList(growable: true);

      setState(() {
        livePrice = alteredList[alteredList.length - 1]["value"];
      });

      x();
    }
  }

  void x() {
    for (int i = 0; i < chartData.length; i++) {
      double timeInSeconds =
          chartData.reversed.toList()[i].date.toDouble() / 1000;
      double timeInHours = timeInSeconds / 60 / 60;

      var xCoordinate =
          (DateTime.now().millisecondsSinceEpoch) / 1000 / 60 / 60 -
              timeInHours;

      var yCoordinate = chartData[i].price.toDouble();

      setState(() {
        var spot = FlSpot(xCoordinate, yCoordinate);

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
    getNewsData();
  }

  getNewsData() async {
    const String newsKey = "5a8b2b1a798b4b94a1d46f0a5689f36c";
    var response = await get(Uri.parse(
        "https://newsapi.org/v2/everything?q=${widget.name}&from=2021-12-24&sortBy=popularity&apiKey=$newsKey"));
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json['articles'];
      for (int i = 0; i < body.length; i++) {
        Map<String, dynamic> map = body[i];
        articleList.add(Article.fromJson(map));
      }
    } else {
      print("error");
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CoinView(
              widget.id,
              widget.name,
              widget.symbol,
              widget.imageUrl,
              livePrice,
              widget.change,
              widget.changePercentage,
              getGraphData,
              spotValues,
              minValue,
              maxValue,
              selectedRange);
        },
      ),
    );
  }

  @override
  void initState() {
    setState(() {
      coinID = widget.id;
      getGraphData(widget.viewRange);
      chartData.clear();
      spotValues.clear();
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
