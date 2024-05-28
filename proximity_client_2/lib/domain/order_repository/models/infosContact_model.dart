class InfosContact {
  int? id;
  Map<String, dynamic> infos;
  bool selected;
  String? dbId;

  InfosContact(
      {this.id, required this.infos, required this.selected, this.dbId});

  InfosContact.fromJson(Map<String, dynamic> parsedJson,
      {bool? selected = false})
      : dbId = parsedJson['_id'] ?? "",
        id = parsedJson['id'] ?? "",
        infos = parsedJson['infos'] ?? "",
        selected = selected == true ? true : (parsedJson['selected'] ?? false);

  static List<InfosContact> storeCategoriesFromJsonList(
      List<dynamic> parsedJson,
      {bool? selected = false}) {
    List<InfosContact> list = [];
    for (int i = 0; i < parsedJson.length; i++) {
      parsedJson[i]["id"] = i + 1;
      list.add(InfosContact.fromJson(parsedJson[i], selected: selected));
    }
    return list;
  }
}
