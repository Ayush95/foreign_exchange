class CurrencyModel {
  Map<String, double> rates;
  String base;

  CurrencyModel({
    this.rates,
    this.base,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
        rates: Map.from(json["rates"]).map(
            (key, value) => MapEntry<String, double>(key, value.toDouble())),
        base: json["base"],
      );
}
