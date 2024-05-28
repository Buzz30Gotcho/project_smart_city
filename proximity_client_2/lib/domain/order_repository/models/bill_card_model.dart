class BillCard {
  String? cardNumber;
  String? cvc;
  String? expdate;
  String? name;
  String? phone;
  String? city;
  String? street;
  String? street2;
  String? postalCode;

  BillCard.fromJson(Map<String, dynamic> parsedJson)
      : cardNumber = parsedJson['cardNumber'],
        cvc = parsedJson['ccv'],
        expdate = parsedJson['expdate'],
        name = parsedJson['name'],
        city = parsedJson['address_city'],
        street = parsedJson['address_line1'],
        street2 = parsedJson['address_line2'],
        phone = parsedJson['phone'],
        postalCode = parsedJson['postalCode'];
}
