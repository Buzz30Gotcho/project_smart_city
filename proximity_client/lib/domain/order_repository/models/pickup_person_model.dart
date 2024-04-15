class PickupPerson {
  int? id;
  String name;
  bool selected;
  String? dbId;

  PickupPerson(
      {this.id, required this.name, required this.selected, this.dbId});

  PickupPerson.fromJson(Map<String, dynamic> parsedJson,
      {bool? selected = false})
      : dbId = parsedJson['_id'] ?? "",
        id = parsedJson['id'] ?? "",
        name = parsedJson['name'] ?? "",
        selected = selected == true ? true : (parsedJson['selected'] ?? false);

  static List<PickupPerson> storeCategoriesFromJsonList(
      List<dynamic> parsedJson,
      {bool? selected = false}) {
    List<PickupPerson> list = [];
    for (int i = 0; i < parsedJson.length; i++) {
      parsedJson[i]["id"] = i + 1;
      list.add(PickupPerson.fromJson(parsedJson[i], selected: selected));
    }
    return list;
  }
}
