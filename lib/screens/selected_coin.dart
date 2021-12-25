import 'package:cypto_tracker_2/main.dart';
import 'package:cypto_tracker_2/widgets/coin_text.dart';
import 'package:flutter/material.dart';
import '../models/chart_model.dart';
import '../widgets/graph.dart';
import 'package:fl_chart/fl_chart.dart';
import 'loading_screen.dart';
import '../widgets/news_card.dart';
import '../widgets/range_buttons.dart';

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

  void _aCallbackFunction(num data) {
    if (data != 0) {
      setState(() {
        livePrice = data;
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
                  widget.change, widget.changePercentage),
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
