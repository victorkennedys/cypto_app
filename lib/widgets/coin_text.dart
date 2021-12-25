import 'package:flutter/material.dart';
import 'package:cypto_tracker_2/constants.dart';

class CoinText extends StatelessWidget {
  CoinText(this.name, this.symbol, this.imageUrl, this.price, this.change,
      this.changeInPercent);

  final String name;
  final String symbol;
  final String imageUrl;
  final double price;
  final double change;
  final double changeInPercent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 30,
                child: Image.network(imageUrl),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(price.toStringAsFixed(0) + " \$", style: coinText),
              change > 0
                  ? Text("+ " + changeInPercent.toStringAsFixed(2) + " %",
                      style: greenText)
                  : Text(
                      changeInPercent.toStringAsFixed(2) + " %",
                      style: redText,
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
