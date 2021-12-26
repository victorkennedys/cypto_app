import 'package:cypto_tracker_2/models/article_model.dart';
import 'package:flutter/material.dart';

import '../models/chart_model.dart';

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
    String url =
        "https://api.coingecko.com/api/v3/coins/$coinID/market_chart/range?vs_currency=usd&from=${date.toInt() / 1000}&to=${maxDate.toInt() / 1000}";
    String todayURL =
        "https://api.coingecko.com/api/v3/coins/$coinID/market_chart/range?vs_currency=usd&from=${yesterday.millisecondsSinceEpoch.toInt() / 1000}&to=${maxDate.toInt() / 1000}";

    var cList = await PriceData.getGraphData(url); //Function 1.

    var currentPrice = await PriceData.getCurrentPrice(
        todayURL); //Function 2 returning current price.

    setState(() {
      livePrice = currentPrice;
    });

    PriceData.addSpotValues(); // function 3, adding values to graph.

    List<double> minMaxList = PriceData.getMaxMinValues();
    maxValue = minMaxList[0];
    minValue = minMaxList[1];

    getNewsData();
  }

  getNewsData() async {
    const String newsKey = "5a8b2b1a798b4b94a1d46f0a5689f36c";
    String newsUrl =
        "https://newsapi.org/v2/everything?q=${widget.name}&from=2021-12-24&sortBy=popularity&apiKey=$newsKey";

    List<Article> articleList = await Article.getNewsArticles(newsUrl);

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
