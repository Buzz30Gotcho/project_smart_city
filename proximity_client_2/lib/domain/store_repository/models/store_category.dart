class StoreCategory {
  int? id;
  String name;
  bool? selected;
  String? dbId;

  StoreCategory({this.id, required this.name, this.selected, this.dbId});

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

final List<StoreCategory> storeCategories = [
  StoreCategory(id: 1, name: 'Accessories'),
  StoreCategory(id: 2, name: 'Grocery'),
  StoreCategory(id: 3, name: 'Clothing'),
  StoreCategory(id: 4, name: 'Electronics'),
  StoreCategory(id: 5, name: 'Home & Furniture'),
  StoreCategory(id: 6, name: 'Health & Beauty'),
  StoreCategory(id: 7, name: 'Sports & Outdoors'),
  StoreCategory(id: 8, name: 'Books & Stationery'),
  StoreCategory(id: 9, name: 'Toys & Games'),
  StoreCategory(id: 10, name: 'Automotive'),
];
