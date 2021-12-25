import 'package:cypto_tracker_2/constants.dart';
import 'package:cypto_tracker_2/screens/loading_screen.dart';
import 'package:flutter/material.dart';

class CoinCard extends StatelessWidget {
  String id;
  String name;
  String symbol;
  String imageUrl;
  dynamic price;
  dynamic change;
  dynamic changePercentage;

  CoinCard(
      @required this.id,
      @required this.name,
      @required this.symbol,
      @required this.imageUrl,
      @required this.price,
      @required this.change,
      @required this.changePercentage);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoadingScreen(id, name, symbol, imageUrl,
                price, change, changePercentage, yesterday),
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
                  imageUrl,
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
                          name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        symbol,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price.toString() + "\$",
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
                            change < 0
                                ? change.toStringAsFixed(1) + "\$"
                                : "\$" '+' + change.toStringAsFixed(1),
                            style: TextStyle(
                                color: change < 0 ? Colors.red : Colors.green,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          changePercentage < 0
                              ? changePercentage.toStringAsFixed(1) + "%"
                              : '+' + changePercentage.toStringAsFixed(1) + "%",
                          style: TextStyle(
                              color: change < 0 ? Colors.red : Colors.green,
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
