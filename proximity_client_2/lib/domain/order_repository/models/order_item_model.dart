import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/cart_repository/models/models.dart';
import 'package:proximity_client/domain/product_repository/models/models.dart';
import 'package:proximity_client/domain/product_repository/models/policy_model.dart';

class OrderItem {
  String? id;
  String? name;
  String? productId;
  String? variantId;
  String? image;
  double? price;
  double discount;
  int orderedQuantity;
  int? returnQuantity;
  double? reservation;
  Policy? policy;

  OrderItem(
      {this.id,
      this.name,
      this.variantId,
      this.image,
      this.price,
      this.discount = 0.0,
      this.orderedQuantity = 1,
      this.returnQuantity = 0,
      this.reservation = 0.0});

  OrderItem.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['_id'],
        name = parsedJson['name'],
        productId = parsedJson['productId'],
        variantId = parsedJson['variantId'],
        orderedQuantity = parsedJson['orderQuantity'] ?? parsedJson['quantity'],
        returnQuantity =
            parsedJson['orderQuantity'] != null ? parsedJson['quantity'] : 0,
        price = parsedJson['price'].toDouble(),
        discount = parsedJson['discount'].toDouble(),
        reservation = (parsedJson['reservation'] ?? 0.0).toDouble(),
        policy = parsedJson['policy'] == null
            ? null
            : Policy.fromJson(parsedJson['policy']),
        image = '$BASE_IMG_URL/' + parsedJson['image'];

  OrderItem.fromCartItem(CartItem cartItem)
      : id = cartItem.id,
        name = cartItem.name,
        variantId = cartItem.variantId,
        image = cartItem.image,
        price = cartItem.price,
        discount = cartItem.discount,
        orderedQuantity = cartItem.orderedQuantity;

  static List<OrderItem> orderItemsFromJsonList(List<dynamic> parsedJson) {
    List<OrderItem> list = [];
    for (int i = 0; i < parsedJson.length; i++) {
      list.add(OrderItem.fromJson(parsedJson[i]));
    }
    return list;
  }

  Product toProduct() => Product(
      id: id,
      name: name,
      price: price,
      discount: discount,
      reservation: reservation);
}
