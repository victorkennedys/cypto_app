import 'dart:convert';
import 'package:http/http.dart';
import 'package:cypto_tracker_2/constants.dart';

class PriceData {
  final double date;
  final double price;

  PriceData(this.date, this.price);

  factory PriceData.fromJson(Map<dynamic, dynamic> json) {
    return PriceData(json["time"].toDouble(), json["value"]);
  }

  /* static Future addToChartData(String coinID, int minDate, int maxDate) async {
    var data = await get(
      Uri.parse(
          "https://api.coingecko.com/api/v3/coins/$coinID/market_chart/range?vs_currency=usd&from=${minDate.toInt() / 1000}&to=${maxDate.toInt() / 1000}"),
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
      return alteredList;
    }
  } */
}

List<PriceData> chartData = [];
