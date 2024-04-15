class StoreCategory {
  int? id;
  String name;
  bool selected;
  String? dbId;
  int? product_count;

  StoreCategory(
      {this.id,
      required this.name,
      required this.selected,
      this.dbId,
      this.product_count});

  StoreCategory.fromJson(Map<String, dynamic> parsedJson,
      {bool? selected = false})
      : dbId = parsedJson['_id'] ?? "",
        id = parsedJson['id'] ?? "",
        name = parsedJson['name'] ?? "",
        product_count = parsedJson['product_count'] ?? 0,
        selected = selected == true ? true : (parsedJson['selected'] ?? false);

  static List<StoreCategory> storeCategoriesFromJsonList(
      List<dynamic> parsedJson,
      {bool? selected = false}) {
    List<StoreCategory> _list = [];
    for (int i = 0; i < parsedJson.length; i++) {
      parsedJson[i]["id"] = i + 1;
      _list.add(StoreCategory.fromJson(parsedJson[i], selected: selected));
    }
    return _list;
  }
}
