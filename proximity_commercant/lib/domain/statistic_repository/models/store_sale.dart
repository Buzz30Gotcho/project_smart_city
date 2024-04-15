class StoreSale {
  String storeName;
  int sales;

  StoreSale({
    required this.storeName,
    required this.sales,
  });

  factory StoreSale.fromJson(Map<String, dynamic> json) {
    return StoreSale(
      storeName: json['storeName'],
      sales: json['numberOfSales'],
    );
  }
  static List<StoreSale> storeSalesFromJsonList(List<dynamic> parsedJson) {
    List<StoreSale> _list = [];
    for (int i = 0; i < parsedJson.length; i++) {
      _list.add(StoreSale.fromJson(parsedJson[i]));
    }
    return _list;
  }
}
