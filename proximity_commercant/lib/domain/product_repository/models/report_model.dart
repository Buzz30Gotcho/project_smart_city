class Report {
  String? id;
  String? message;
  DateTime? date;
  String? userId;

  Report({this.id, this.message, this.date, this.userId});

  Report.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['_id'],
        message = parsedJson['message'],
        date = DateTime.parse(parsedJson['date']),
        userId = parsedJson['idUser'];

  static List<Report> productsFromJsonList(List<dynamic> parsedJson) {
    List<Report> _list = [];
    for (int i = 0; i < parsedJson.length; i++) {
      _list.add(Report.fromJson(parsedJson[i]));
    }
    return _list;
  }
}
