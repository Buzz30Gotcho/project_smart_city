import 'bill_card_model.dart';

class Bill {
  double? totalAmount;
  int? paymentMethodeId;
  BillCard? card;

  Bill.fromJson(Map<String, dynamic> parsedJson)
      : totalAmount = parsedJson['totalAmount'] != null
            ? parsedJson['totalAmount'].toDouble()
            : 0.0,
        paymentMethodeId = parsedJson['paymentMethodeId'],
        card = parsedJson['card'] != null
            ? BillCard.fromJson(parsedJson['card'])
            : null;
}
