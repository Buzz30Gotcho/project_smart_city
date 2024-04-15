class ProductView {
  String productName;
  int views;

  ProductView({
    required this.productName,
    required this.views,
  });

  factory ProductView.fromJson(Map<String, dynamic> json) {
    return ProductView(
      productName: json['productName'],
      views: json['numberOfViews'],
    );
  }
  static List<ProductView> productsViewFromJsonList(List<dynamic> parsedJson) {
    List<ProductView> _list = [];
    for (int i = 0; i < parsedJson.length; i++) {
      _list.add(ProductView.fromJson(parsedJson[i]));
    }
    return _list;
  }
}
