import 'package:cypto_tracker_2/constants.dart';
import 'package:cypto_tracker_2/models/chart_model.dart';
import 'package:cypto_tracker_2/screens/loading_screen.dart';
import 'package:cypto_tracker_2/widgets/graph.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CoinCard extends StatefulWidget {
  String id;
  String name;
  String symbol;
  String imageUrl;
  dynamic price;
  dynamic change;
  dynamic changePercentage;
  final Function getGraphData;
  final Function fetchCoins;

  CoinCard(
      @required this.id,
      @required this.name,
      @required this.symbol,
      @required this.imageUrl,
      @required this.price,
      @required this.change,
      @required this.changePercentage,
      this.getGraphData,
      this.fetchCoins);

  @override
  State<CoinCard> createState() => _CoinCardState();
}

late Function callback;
late double minValue;
late double maxValue;
List<FlSpot> spotList = [];

class _CoinCardState extends State<CoinCard> {
  Future<CoinGraph> t() async {
    List x = await widget.getGraphData(yesterday, widget.id);
    setState(() {
      callback = x[1];
      minValue = x[2];
      maxValue = x[3];
      spotList = x[4];
    });
    return CoinGraph(callback, minValue, maxValue, spotList);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoadingScreen(
                widget.id,
                widget.name,
                widget.symbol,
                widget.imageUrl,
                widget.price,
                widget.change,
                widget.changePercentage,
                yesterday),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  widget.imageUrl,
                  height: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          widget.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        widget.symbol,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                FutureBuilder<CoinGraph>(
                  future: t(),
                  builder: (context, AsyncSnapshot<CoinGraph> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Text("Error");
                      } else if (snapshot.hasData) {
                        return CoinGraph(
                            callback, minValue, maxValue, spotValues);
                        /* return snapshot.data as Widget; */
                      } else {
                        return Text("Empty data");
                      }
                    } else {
                      return Text("State: ${snapshot.connectionState}");
                    }
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.price.toString() + "\$",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            widget.change < 0
                                ? widget.change.toStringAsFixed(1) + "\$"
                                : "\$" '+' + widget.change.toStringAsFixed(1),
                            style: TextStyle(
                                color: widget.change < 0
                                    ? Colors.red
                                    : Colors.green,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          widget.changePercentage < 0
                              ? widget.changePercentage.toStringAsFixed(1) + "%"
                              : '+' +
                                  widget.changePercentage.toStringAsFixed(1) +
                                  "%",
                          style: TextStyle(
                              color:
                                  widget.change < 0 ? Colors.red : Colors.green,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            Divider(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
