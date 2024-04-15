class ProductCategory {
  int? id;
  String name;
  bool selected;
  List<ProductSubCategory> subCategories;
  String? dbId;
  int? storeCategoryId;
  String? storeCategoryDBId;
  int? product_count;

  ProductCategory(
      {this.id,
      required this.name,
      required this.selected,
      required this.subCategories,
      this.dbId,
      this.storeCategoryId,
      this.storeCategoryDBId,
      this.product_count});

  ProductCategory.fromJson(Map<String, dynamic> parsedJson)
      : dbId = parsedJson['_id'] ?? "",
        id = parsedJson['id'] ?? "",
        storeCategoryDBId = parsedJson['storeCategoryId'] ?? "",
        name = parsedJson['name'] ?? "",
        product_count = parsedJson['product_count'] ?? 0,
        selected = parsedJson['selected'] ?? false,
        subCategories = ProductSubCategory.productSubCategoriesFromJsonList(
            parsedJson["subCategories"] ?? []);

  static List<ProductCategory> productCategoriesFromJsonList(
      List<dynamic> parsedJson) {
    List<ProductCategory> _list = [];
    for (int i = 0; i < parsedJson.length; i++) {
      parsedJson[i]["id"] = i + 1;
      _list.add(ProductCategory.fromJson(parsedJson[i]));
    }
    return _list;
  }
}

class ProductSubCategory {
  int? id;
  String name;
  bool selected;
  String? dbId;
  int? product_count;

  ProductSubCategory(
      {this.id,
      required this.name,
      required this.selected,
      this.dbId,
      this.product_count});

  ProductSubCategory.fromJson(Map<String, dynamic> parsedJson)
      : dbId = parsedJson['_id'] ?? "",
        id = parsedJson['id'] ?? "",
        name = parsedJson['name'] ?? "",
        product_count = parsedJson['product_count'] ?? 0,
        selected = parsedJson['selected'] ?? false;

  static List<ProductSubCategory> productSubCategoriesFromJsonList(
      List<dynamic> parsedJson) {
    List<ProductSubCategory> _list = [];
    for (int i = 0; i < parsedJson.length; i++) {
      parsedJson[i]["id"] = i + 1;
      _list.add(ProductSubCategory.fromJson(parsedJson[i]));
    }
    return _list;
  }
}
