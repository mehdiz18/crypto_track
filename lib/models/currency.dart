class Currency {
  String id;
  String name;
  String icon;
  double exchangeRate;
  double change;
  double marketCapacity;
  double supply;
  double maxSupply;
  double volume;
  Currency(this.id, this.name, this.icon, this.exchangeRate, this.change,
      this.marketCapacity, this.supply, this.maxSupply, this.volume);

  factory Currency.fromMap(Map<String, dynamic> map) {
    return Currency(
        map["id"],
        map["name"],
        map["icon"],
        map["rate"],
        map["changePercent24Hr"],
        map["marketCapUsd"],
        map["supply"],
        map["maxSupply"],
        map["volume"]);
  }

  @override
  String toString() {
    return '$id $name $icon ${exchangeRate.toStringAsFixed(4)}';
  }
}
