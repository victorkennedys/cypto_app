import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cypto_tracker_2/constants.dart';
import 'package:http/http.dart';

class SelectedCoin extends StatefulWidget {
  final String name;
  final String symbol;
  final String imageUrl;
  final dynamic price;
  final dynamic change;
  final dynamic changePercentage;

  SelectedCoin(this.name, this.symbol, this.imageUrl, this.price, this.change,
      this.changePercentage);

  @override
  State<SelectedCoin> createState() => _SelectedCoinState();
}

class _SelectedCoinState extends State<SelectedCoin> {
  void getGraphData(DateTime range) async {
    int date = range.toUtc().millisecondsSinceEpoch;
    int maxDate = (DateTime.now().toUtc()).millisecondsSinceEpoch;

    var data = await get(
      Uri.parse(
          "https://api.coingecko.com/api/v3/coins/bitcoin/market_chart/range?vs_currency=usd&from=${date.toInt() / 1000}&to=${maxDate.toInt() / 1000}"),
    );
    if (data.statusCode == 200) {
      List<dynamic> pricesList = jsonDecode(data.body)["prices"];
      /* print(pricesList); */
      /* for (List i in pricesList) {
        print(i);
        
      } */
      var list = pricesList
          .map((e) => {"time": e[0], "value": e[1]})
          .toList(growable: true);
      print(list[0]["time"]);

      //error datelist = 0!!
      /* if (dataList.length > 0) {
        for (int i = 0; i < dataList.length; i++) {
          if (dataList[i] != null) {
            /* Map<String, dynamic> map = dataList[i]; */
            /*  print(map); */
          }
        }
      } */
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(
          "${widget.name}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              RangeSelector("3y", getGraphData, threeYearAgo),
              RangeSelector("1y", getGraphData, yearAgo),
              RangeSelector("6m", getGraphData, sixMonthsAgo),
              RangeSelector("3m", getGraphData, threeMonthsAgo),
              RangeSelector("1m", getGraphData, monthAgo),
              RangeSelector("1w", getGraphData, weekAgo),
              RangeSelector("1d", getGraphData, yesterday),
            ],
          )
        ],
      ),
    );
  }
}

class RangeSelector extends StatelessWidget {
  final String text;
  final Function selectRange;
  final DateTime functionInput;

  RangeSelector(this.text, this.selectRange, this.functionInput);
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FlatButton(
        child: Text(text),
        onPressed: () {
          selectRange(functionInput);
        },
      ),
    );
  }
}
