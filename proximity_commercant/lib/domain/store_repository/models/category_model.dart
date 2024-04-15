class Category {
  String? id;
  String? name;
  String? description;
  List<String>? productIds;

  Category({this.id, this.name, this.description, this.productIds});

  Category.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['_id'],
        name = parsedJson['name'],
        description = parsedJson['description'];
        // productIds = parsedJson['name'],

  static List<Category> categoriesFromJsonList(List<dynamic> parsedJson) {
    List<Category> _list = [];
    for (int i = 0; i < parsedJson.length; i++) {
      _list.add(Category.fromJson(parsedJson[i]));
    }
    return _list;
  }
}
