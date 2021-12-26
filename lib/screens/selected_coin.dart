import 'package:cypto_tracker_2/main.dart';
import 'package:cypto_tracker_2/widgets/coin_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/chart_model.dart';
import '../widgets/graph.dart';
import 'package:fl_chart/fl_chart.dart';
import 'loading_screen.dart';
import '../widgets/news_card.dart';
import '../widgets/range_buttons.dart';
import 'package:cypto_tracker_2/constants.dart';

class CoinView extends StatefulWidget {
  final String id;
  final String name;
  final String symbol;
  final String imageUrl;
  dynamic price;
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

  late dynamic livePrice = widget.price;
  String dateFormat = DateFormat('yy-MM-dd').format(DateTime.now());
  String timeFormat = DateFormat('kk:mm').format(DateTime.now());
  late String liveDate =
      widget.selectedRange != yesterday ? dateFormat : timeFormat;
  List touchedSpotsReciever = [];
  late int counter;

  void _aCallbackFunction(num y, num x) {
    DateTime now = DateTime.now();
    DateTime cursoredDate =
        widget.selectedRange.add(Duration(hours: x.toInt()));
    String formattedDate = widget.selectedRange != yesterday
        ? DateFormat('yy-MM-dd').format(cursoredDate)
        : DateFormat('kk:mm').format(cursoredDate);

    if (y != 0) {
      setState(() {
        liveDate = formattedDate;
        livePrice = y;
      });
    } else if (y == 0) {
      setState(() {
        widget.selectedRange != yesterday
            ? liveDate = dateFormat
            : liveDate = timeFormat;
        livePrice = widget.price;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white.withOpacity(0.5),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CoinText(widget.name, widget.symbol, widget.imageUrl, livePrice,
                  widget.change, widget.changePercentage, liveDate),
              SizedBox(
                height: 20,
              ),
              CoinGraph(_aCallbackFunction, widget.minValue, widget.maxValue,
                  widget.spotValues),
              RangeRow(changeRange, widget.selectedRange),
            ],
          ),
          NewsCard(widget.name),
        ],
      ),
    );
  }
}
