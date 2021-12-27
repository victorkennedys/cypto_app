import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart';

class PriceData {
  final double date;
  final double price;

  PriceData(this.date, this.price);

  static Future<List<PriceData>> getGraphData(String url) async {
    var data = await get(Uri.parse(url));
    if (data.statusCode == 200) {
      List<dynamic> pricesList = jsonDecode(data.body)["prices"];
      var list = pricesList
          .map((e) => {"time": e[0], "value": e[1]})
          .toList(growable: true);

      for (Map i in list) {
        chartData.add(PriceData.fromJson(i));
      }
      return chartData;
    }
    return chartData;
  }

  static getCurrentPrice(String url) async {
    var todayPrice = await get(Uri.parse(url));
    List<dynamic> todayList = jsonDecode(todayPrice.body)["prices"];
    var alteredList = todayList
        .map((e) => {"time": e[0], "value": e[1]})
        .toList(growable: true);
    double livePrice = alteredList[alteredList.length - 1]["value"];
    return livePrice;
  }

  static addSpotValues() {
    for (int i = 0; i < chartData.length; i++) {
      double timeInSeconds =
          chartData.reversed.toList()[i].date.toDouble() / 1000;

      double timeInHours = timeInSeconds / 60 / 60;

      var xCoordinate =
          (DateTime.now().millisecondsSinceEpoch) / 1000 / 60 / 60 -
              timeInHours;

      var yCoordinate = chartData[i].price.toDouble();

      var spot = FlSpot(xCoordinate, yCoordinate);

      spotValues.add(spot);
    }
    return spotValues;
  }

  static getMaxMinValues() {
    List<double> minMaxList = [];
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
    minMaxList.add(largestValue);
    minMaxList.add(smallestValue);
    return minMaxList;
  }

  factory PriceData.fromJson(Map<dynamic, dynamic> json) {
    return PriceData(json["time"].toDouble(), json["value"]);
  }
}

List<PriceData> chartData = [];

List<FlSpot> spotValues = [];
