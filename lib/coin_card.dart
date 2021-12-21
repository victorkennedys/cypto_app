import 'package:cypto_tracker_2/screens/selected_coin.dart';
import 'package:flutter/material.dart';

class CoinCard extends StatelessWidget {
  String name;
  String symbol;
  String imageUrl;
  dynamic price;
  dynamic change;
  dynamic changePercentage;

  CoinCard(
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
            builder: (context) => SelectedCoin(
                name, symbol, imageUrl, price, change, changePercentage),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(1, 1),
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.grey,
                offset: Offset(-1, -1),
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(2, 2),
                        spreadRadius: 1,
                        blurRadius: 4,
                      ),
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(-2, -2),
                          spreadRadius: 1,
                          blurRadius: 4),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.network(imageUrl),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          name,
                          style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        symbol,
                        style: TextStyle(
                          color: Colors.grey[900],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price.toString() + "\$",
                      style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        change < 0
                            ? change.toStringAsFixed(1) + "\$"
                            : "\$" '+' + change.toStringAsFixed(1),
                        style: TextStyle(
                            color: change < 0 ? Colors.red : Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      changePercentage < 0
                          ? changePercentage.toStringAsFixed(1) + "%"
                          : '+' + changePercentage.toStringAsFixed(1) + "%",
                      style: TextStyle(
                          color: change < 0 ? Colors.red : Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
