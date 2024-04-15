class ProductSale {
  String productName;
  int sales;

  ProductSale({
    required this.productName,
    required this.sales,
  });

  factory ProductSale.fromJson(Map<String, dynamic> json) {
    return ProductSale(
      productName: json['productName'],
      sales: json['numberOfSales'],
    );
  }
  static List<ProductSale> productsSaleFromJsonList(List<dynamic> parsedJson) {
    List<ProductSale> _list = [];
    for (int i = 0; i < parsedJson.length; i++) {
      _list.add(ProductSale.fromJson(parsedJson[i]));
    }
    return _list;
  }
}
