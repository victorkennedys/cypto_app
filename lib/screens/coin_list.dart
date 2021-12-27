import 'package:flutter/material.dart';
import '../models/coin_model.dart';
import '../widgets/coin_card.dart';

class CoinListView extends StatelessWidget {
  final Function getGraphData;
  final Function fetchCoins;
  CoinListView(this.getGraphData, this.fetchCoins);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(
          "CryptoBase",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: coinList.length,
        itemBuilder: (context, index) {
          return CoinCard(
              coinList[index].id,
              coinList[index].name,
              coinList[index].symbol,
              coinList[index].imageUrl,
              coinList[index].price,
              coinList[index].change,
              coinList[index].changePercentage,
              getGraphData,
              fetchCoins);
        },
      ),
    );
  }
}
