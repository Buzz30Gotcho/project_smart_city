class StoreView {
  String storeName;
  int views;

  StoreView({
    required this.storeName,
    required this.views,
  });

  factory StoreView.fromJson(Map<String, dynamic> json) {
    return StoreView(
      storeName: json['storeName'],
      views: json['numberOfViews'],
    );
  }
  static List<StoreView> storeViewsFromJsonList(List<dynamic> parsedJson) {
    List<StoreView> _list = [];
    for (int i = 0; i < parsedJson.length; i++) {
      _list.add(StoreView.fromJson(parsedJson[i]));
    }
    return _list;
  }
}
