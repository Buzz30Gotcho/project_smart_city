class RegionSale {
  String regionName;
  int sales;

  RegionSale({
    required this.regionName,
    required this.sales,
  });

  factory RegionSale.fromJson(Map<String, dynamic> json) {
    final String regionName = json['region'] ?? "Unknown";
    final int sales = json['numberOfSales'] ?? 0;

    // Handle the case where sales is missing or negative
    final int validSales = sales >= 0 ? sales : 0;

    return RegionSale(
      regionName: regionName,
      sales: validSales,
    );
  }

  static List<RegionSale> regionsSalesFromJsonList(List<dynamic> parsedJson) {
    List<RegionSale> _list = [];
    for (int i = 0; i < parsedJson.length; i++) {
      _list.add(RegionSale.fromJson(parsedJson[i]));
    }
    return _list;
  }
}
