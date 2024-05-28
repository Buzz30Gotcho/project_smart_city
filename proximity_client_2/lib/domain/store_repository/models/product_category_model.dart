class ProductCategory {
  int? id;
  String name;
  bool selected;
  List<ProductSubCategory> subCategories;
  String? dbId;

  ProductCategory(
      {this.id,
      required this.name,
      required this.selected,
      required this.subCategories,
      this.dbId});

  ProductCategory.fromJson(Map<String, dynamic> parsedJson)
      : dbId = parsedJson['_id'] ?? "",
        id = parsedJson['id'] ?? "",
        name = parsedJson['name'] ?? "",
        selected = parsedJson['selected'] ?? false,
        subCategories = ProductSubCategory.productSubCategoriesFromJsonList(
            parsedJson["subCategories"] ?? []);

  static List<ProductCategory> productCategoriesFromJsonList(
      List<dynamic> parsedJson) {
    List<ProductCategory> list = [];
    for (int i = 0; i < parsedJson.length; i++) {
      parsedJson[i]["id"] = i + 1;
      list.add(ProductCategory.fromJson(parsedJson[i]));
    }
    return list;
  }
}

class ProductSubCategory {
  int? id;
  String name;
  bool selected;
  String? dbId;

  ProductSubCategory(
      {this.id, required this.name, required this.selected, this.dbId});

  ProductSubCategory.fromJson(Map<String, dynamic> parsedJson)
      : dbId = parsedJson['_id'] ?? "",
        id = parsedJson['id'] ?? "",
        name = parsedJson['name'] ?? "",
        selected = parsedJson['selected'] ?? false;

  static List<ProductSubCategory> productSubCategoriesFromJsonList(
      List<dynamic> parsedJson) {
    List<ProductSubCategory> list = [];
    for (int i = 0; i < parsedJson.length; i++) {
      parsedJson[i]["id"] = i + 1;
      list.add(ProductSubCategory.fromJson(parsedJson[i]));
    }
    return list;
  }
}
