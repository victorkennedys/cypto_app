import 'dart:convert';

import 'package:cypto_tracker_2/constants.dart';
import 'package:cypto_tracker_2/models/chart_model.dart';
import 'package:cypto_tracker_2/models/coin_model.dart';
import 'package:cypto_tracker_2/screens/loading_screen.dart';
import 'package:cypto_tracker_2/widgets/graph.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import './screens/coin_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Coin>> fetchCoin() async {
    coinList = [];
    final response = await get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));
    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = jsonDecode(response.body);

      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            coinList.add(Coin.fromJson(map));
          }
        }

        setState(() {
          coinList;
        });
      }
      return coinList;
    } else {
      throw Exception("Failed to load coins");
    }
  }

  num minDate = 0;
  num maxDate = 0;
  DateTime selectedRange = DateTime.now();
  String coinID = "";
  var maxValue;
  var minValue;
  var livePrice;

  Future<List> getGraphData(DateTime range, String coin) async {
    setState(() {
      selectedRange = range;
    });
    int date = range.millisecondsSinceEpoch;
    int maxDate = (DateTime.now()).millisecondsSinceEpoch;
    String url =
        "https://api.coingecko.com/api/v3/coins/$coin/market_chart/range?vs_currency=usd&from=${date.toInt() / 1000}&to=${maxDate.toInt() / 1000}";
    String todayURL =
        "https://api.coingecko.com/api/v3/coins/$coin/market_chart/range?vs_currency=usd&from=${yesterday.millisecondsSinceEpoch.toInt() / 1000}&to=${maxDate.toInt() / 1000}";

    var cList = await PriceData.getGraphData(url); //Function 1.

    var currentPrice = await PriceData.getCurrentPrice(
        todayURL); //Function 2 returning current price.

    setState(() {
      livePrice = currentPrice;
    });

    List<FlSpot> graphData =
        await PriceData.addSpotValues(); // function 3, adding values to graph.

    List<double> minMaxList = PriceData.getMaxMinValues();
    maxValue = minMaxList[0];
    minValue = minMaxList[1];

    List returnList = [() {}, minValue, maxValue, graphData];

    return returnList;
  }

  @override
  void initState() {
    fetchCoin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CoinListView(getGraphData, fetchCoin);
  }
}
