class Coin {
  String name;
  String symbol;
  String imageUrl;
  dynamic price;
  dynamic change;
  dynamic changePercentage;

  Coin(this.name, this.symbol, this.imageUrl, this.price, this.change,
      this.changePercentage);

  factory Coin.fromJson(Map<String, dynamic> json) {
    var currentPrice = json['current_price'];
    currentPrice = currentPrice.toStringAsFixed(1);

    /* var changePercentage = json['price_change_percentage_24h'];
    changePercentage = changePercentage.toStringAsFixed(1);
 */
    return Coin(json['name'], json['symbol'], json['image'], currentPrice,
        json['price_change_24h'], json['price_change_percentage_24h']);
  }
}

List<Coin> coinList = [];
