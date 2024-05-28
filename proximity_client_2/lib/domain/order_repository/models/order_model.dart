import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/order_repository/models/bill_model.dart';

import 'order_item_model.dart';

class Order {
  String? id;
  String? clientId;

  String? storeId;
  String? storeName;
  String? storePhone;
  String? storeImage;
  Address? storeAddress;

  Map<String, String>? pickupPerson;
  Address? shippingAddress;

  Bill? paymentInfo;
  String? currency;

  double? totalPrice;
  DateTime? orderDate;

  bool? reservation;
  bool? delivery;
  bool? pickup;
  bool? canceled;
  Map<String, String>? canceledBy;

  DateTime? deliveryDate;
  DateTime? timeLimit;
  List<OrderItem>? items;

  bool? returnOrder;
  List<OrderItem>? returnedItems;
  List<OrderItem>? acceptedReturnedItems;
  String? returnMotif;
  bool? returned;
  bool? waitingforReturn;
  bool? refund;

  String? orderStatus;
  Bill? refundPaymentInfo;

  Order(
      {this.id,
      this.clientId,
      this.storeId,
      this.storeName,
      this.storeAddress,
      this.storePhone,
      this.storeImage,
      this.pickupPerson,
      this.shippingAddress,
      this.paymentInfo,
      this.currency,
      this.totalPrice,
      this.orderDate,
      this.reservation,
      this.delivery,
      this.pickup,
      this.deliveryDate,
      this.timeLimit,
      this.items,
      this.orderStatus,
      this.canceled,
      this.canceledBy});

  Order.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['_id'],
        clientId = parsedJson['clientId'],
        storeId = parsedJson['storeId'],
        storeName = parsedJson['store']['name'],
        storePhone = parsedJson['seller']['phone'],
        storeImage =
            parsedJson['store'] != null && parsedJson['store']["image"] != null
                ? '$BASE_IMG_URL/' + parsedJson['store']["image"]
                : "",
        storeAddress = Address(
            city: parsedJson['store']['address']['city'],
            fullAddress: parsedJson['store']['address']['fullAdress'],
            streetName: parsedJson['store']['address']['streetName'],
            countryName: "France",
            postalCode: parsedJson['store']['postalCode']),
        pickupPerson = parsedJson['pickupPerson'] != null
            ? {"name": parsedJson['pickupPerson']["name"]}
            : null,
        totalPrice = parsedJson['paymentInfos']['totalAmount'].toDouble(),
        currency = '€',
        orderDate = DateTime.now(),
        deliveryDate = DateTime.now(),
        items = OrderItem.orderItemsFromJsonList(parsedJson['items']),
        returnedItems = parsedJson['returnItems'] != null
            ? OrderItem.orderItemsFromJsonList(parsedJson['returnItems'])
            : null,
        acceptedReturnedItems = parsedJson['returnedItems'] != null
            ? OrderItem.orderItemsFromJsonList(parsedJson['returnedItems'])
            : null,
        returnOrder = parsedJson['return'],
        waitingforReturn = parsedJson['waitingforReturn'],
        returned = parsedJson['returned'],
        paymentInfo = Bill.fromJson(parsedJson['paymentInfos']),
        refundPaymentInfo = parsedJson['refundPaymentInfos'] != null &&
                parsedJson['refundPaymentInfos']["totalAmount"] != null
            ? Bill.fromJson(parsedJson['refundPaymentInfos'])
            : null,
        refund = parsedJson['refund'],
        shippingAddress = Address(
            city: parsedJson['deliveryAddresse'] != null &&
                    parsedJson['deliveryAddresse']["city"] != null
                ? parsedJson['deliveryAddresse']["city"]
                : "",
            countryName: "France",
            postalCode: parsedJson['deliveryAddresse'] != null &&
                    parsedJson['deliveryAddresse']["postalCode"] != null
                ? parsedJson['deliveryAddresse']["postalCode"]
                : "",
            fullAddress: parsedJson['deliveryAddresse'] != null &&
                    parsedJson['deliveryAddresse']["fullAdress"] != null
                ? parsedJson['deliveryAddresse']["fullAdress"]
                : "",
            streetName: parsedJson['deliveryAddresse'] != null &&
                    parsedJson['deliveryAddresse']["streetName"] != null
                ? parsedJson['deliveryAddresse']["streetName"]
                : "",
            region: parsedJson['deliveryAddresse'] != null &&
                    parsedJson['deliveryAddresse']["region"] != null
                ? parsedJson['deliveryAddresse']["region"]
                : ""),
        delivery = parsedJson['delivery'],
        pickup = parsedJson['pickUp'],
        reservation = parsedJson['reservation'],
        returnMotif = parsedJson['returnMotif'],
        canceled = parsedJson['canceled'] ?? false,
        canceledBy = parsedJson['canceledBy'] != null &&
                parsedJson['canceledBy']["userId"] != null
            ? {
                "userId": parsedJson['canceledBy']["userId"],
                "name": parsedJson['canceledBy']["name"],
                "image": '$BASE_IMG_URL/' + parsedJson['canceledBy']["image"],
                "motif": parsedJson['canceledBy']["motif"],
              }
            : null,
        orderStatus = parsedJson['status'];

  static List<Order> ordersFromJsonList(List<dynamic> parsedJson) {
    List<Order> list = [];
    for (int i = 0; i < parsedJson.length; i++) {
      list.add(Order.fromJson(parsedJson[i]));
    }
    return list;
  }
}
