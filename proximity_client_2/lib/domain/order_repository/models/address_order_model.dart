import 'package:proximity/proximity.dart';

class AddressOrder {
  int? id;
  bool selected;
  String? dbId;
  Address? address;

  AddressOrder({this.id, required this.selected, this.dbId, this.address});

  AddressOrder.fromJson(Map<String, dynamic> parsedJson,
      {bool? selected = false})
      : dbId = parsedJson['_id'] ?? "",
        id = parsedJson['id'] ?? "",
        address = Address(
          lat: (parsedJson['deliveryLocation']['coordinates'][1] ?? 0)
              .toDouble(),
          lng: (parsedJson['deliveryLocation']['coordinates'][0] ?? 0)
              .toDouble(),
          city: parsedJson['deliveryAddresse']['city'],
          streetName: parsedJson['deliveryAddresse']['streetName'],
          postalCode: parsedJson['deliveryAddresse']['postalCode'],
          countryCode: parsedJson['deliveryAddresse']['countryCode'],
          countryName: parsedJson['deliveryAddresse']['country'],
          fullAddress: parsedJson['deliveryAddresse']['fullAdress'],
          locality: parsedJson['deliveryAddresse']['region'],
          region: parsedJson['deliveryAddresse']['region'],
        ),
        selected = selected == true ? true : (parsedJson['selected'] ?? false);

  static List<AddressOrder> storeCategoriesFromJsonList(
      List<dynamic> parsedJson,
      {bool? selected = false}) {
    List<AddressOrder> list = [];
    for (int i = 0; i < parsedJson.length; i++) {
      parsedJson[i]["id"] = i + 1;
      list.add(AddressOrder.fromJson(parsedJson[i], selected: selected));
    }
    return list;
  }
}
