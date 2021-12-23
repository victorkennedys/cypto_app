import 'package:fl_chart/fl_chart.dart';

class PriceData {
  final double date;
  final double price;

  PriceData(this.date, this.price);

  factory PriceData.fromJson(Map<dynamic, dynamic> json) {
    return PriceData(json["time"].toDouble(), json["value"]);
  }
}

List<PriceData> chartData = [];
