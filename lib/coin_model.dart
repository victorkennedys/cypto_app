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
    return Coin(
        json['name'],
        json['symbol'],
        json['image'],
        json['curent_price'],
        json['price_change_24h'],
        json['price_change_percentage_24h']);
  }
}

List<Coin> coinList = [];
