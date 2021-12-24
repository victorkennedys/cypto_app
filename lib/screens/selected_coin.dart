import 'package:cypto_tracker_2/main.dart';
import 'package:flutter/material.dart';
import 'package:cypto_tracker_2/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/chart_model.dart';
import '../widgets/graph.dart';
import 'package:fl_chart/fl_chart.dart';
import 'loading_screen.dart';
import '../widgets/coin_text.dart';
import '../widgets/news_card.dart';

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

  @override
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    void _aCallbackFunction(double data) {
      livePrice = data;
      print(livePrice);
    }

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
        actions: [
          Row(
            children: [
              TextButton(
                child: Text("Buy"),
                onPressed: () {},
                style: ButtonStyle(),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    height: 30,
                                    child: Image.network(widget.imageUrl),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  livePrice.toStringAsFixed(0) + " \$",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                widget.change > 0
                                    ? Text(
                                        "+ " +
                                            widget.changePercentage
                                                .toStringAsFixed(2) +
                                            " %",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        widget.changePercentage
                                                .toStringAsFixed(2) +
                                            " %",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      /* PriceText(widget.price, widget.change, widget.changePercentage), */
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 350,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: LineChart(
                        LineChartData(
                          lineTouchData: LineTouchData(
                            enabled: true,
                            touchTooltipData: LineTouchTooltipData(
                                tooltipBgColor: Colors.transparent,
                                getTooltipItems: (touchedSpots) {
                                  _aCallbackFunction(touchedSpots[0].y);
                                  return touchedSpots
                                      .map((LineBarSpot touchedSpot) {
                                    final textStyle = TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    );

                                    return LineTooltipItem(
                                        touchedSpot.y.toStringAsFixed(0),
                                        textStyle);
                                  }).toList();
                                }),
                          ),
                          borderData: FlBorderData(show: false),
                          gridData: FlGridData(
                            show: false,
                          ),
                          minX: (DateTime.now().millisecondsSinceEpoch -
                                  chartData[chartData.length - 1].date) /
                              (1000 * 60 * 60),
                          maxX: (DateTime.now().millisecondsSinceEpoch -
                                  chartData[1].date) /
                              (1000 * 60 * 60),
                          minY: widget.minValue,
                          maxY: widget.maxValue,
                          titlesData: LineTitles.getTitleData(),
                          lineBarsData: [
                            LineChartBarData(
                              spots: widget.spotValues,
                              isCurved: true,
                              colors: gradientColors,
                              barWidth: 2,
                              dotData: FlDotData(
                                show: false,
                              ),
                              belowBarData: BarAreaData(
                                show: true,
                                colors: gradientColors
                                    .map((color) => color.withOpacity(0.3))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  RangeSelector(
                      "3y",
                      changeRange,
                      threeYearAgo,
                      widget.selectedRange == threeYearAgo
                          ? Colors.white.withOpacity(0.2)
                          : Colors.transparent),
                  RangeSelector(
                      "1y",
                      changeRange,
                      yearAgo,
                      widget.selectedRange == yearAgo
                          ? Colors.white.withOpacity(0.2)
                          : Colors.transparent),
                  RangeSelector(
                      "6m",
                      changeRange,
                      sixMonthsAgo,
                      widget.selectedRange == sixMonthsAgo
                          ? Colors.white.withOpacity(0.2)
                          : Colors.transparent),
                  RangeSelector(
                      "3m",
                      changeRange,
                      threeMonthsAgo,
                      widget.selectedRange == threeMonthsAgo
                          ? Colors.white.withOpacity(0.2)
                          : Colors.transparent),
                  RangeSelector(
                      "1m",
                      changeRange,
                      monthAgo,
                      widget.selectedRange == monthAgo
                          ? Colors.white.withOpacity(0.2)
                          : Colors.transparent),
                  RangeSelector(
                      "1w",
                      changeRange,
                      weekAgo,
                      widget.selectedRange == weekAgo
                          ? Colors.white.withOpacity(0.2)
                          : Colors.transparent),
                  RangeSelector(
                      "1d",
                      changeRange,
                      yesterday,
                      widget.selectedRange == yesterday
                          ? Colors.white.withOpacity(0.2)
                          : Colors.transparent),
                ],
              ),
              Row(
                children: [
                  FlatButton(onPressed: () {}, child: Text("Buy")),
                  FlatButton(onPressed: () {}, child: Text("Sell")),
                ],
              )
            ],
          ),
          NewsCard(widget.name),
        ],
      ),
    );
  }
}

class RangeSelector extends StatelessWidget {
  final String text;
  final Function selectRange;
  final DateTime functionInput;
  final Color color;

  RangeSelector(this.text, this.selectRange, this.functionInput, this.color);
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FlatButton(
        color: color,
        child: Text(text),
        onPressed: () {
          selectRange(functionInput);
        },
      ),
    );
  }
}
