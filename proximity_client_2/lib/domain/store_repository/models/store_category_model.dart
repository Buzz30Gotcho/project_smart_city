class StoreCategory {
  int? id;
  String name;
  bool selected;
  String? dbId;

  StoreCategory(
      {this.id, required this.name, required this.selected, this.dbId});

  StoreCategory.fromJson(Map<String, dynamic> parsedJson)
      : dbId = parsedJson['_id'] ?? "",
        id = parsedJson['id'] ?? "",
        name = parsedJson['name'] ?? "",
        selected = parsedJson['selected'] ?? false;

  static List<StoreCategory> storeCategoriesFromJsonList(
      List<dynamic> parsedJson) {
    List<StoreCategory> list = [];
    for (int i = 0; i < parsedJson.length; i++) {
      parsedJson[i]["id"] = i + 1;
      list.add(StoreCategory.fromJson(parsedJson[i]));
    }
    return list;
  }
}
