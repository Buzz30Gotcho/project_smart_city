import 'dart:convert';
import 'package:proximity/proximity.dart';
import 'package:flutter/material.dart';
import 'package:proximity_client/domain/order_repository/order_repository.dart';

class ReturnScreenValidation with ChangeNotifier {
  List<OrderItem>? _returnedItems = [];
  List<OrderItem>? get returnedItems => _returnedItems;

  void changeReturnedItems(List<OrderItem> newItems) {
    _returnedItems = [];
    _returnedItems!.addAll(newItems);
    notifyListeners();
  }

  void changeReturnedItemQuantity(int value, String? id) {
    int index = _returnedItems!.indexWhere((item) => item.variantId == id);
    if (index != -1 && value <= _returnedItems![index].orderedQuantity) {
      _returnedItems![index].returnQuantity = value;
    }
    notifyListeners();
  }

  ReturnScreenValidation.initProducts(List<OrderItem> new_products) {
    _returnedItems = [];
    _returnedItems!.addAll(new_products);
    notifyListeners();
  }

  String itemsToString() {
    List<Map<String, dynamic>> items = [];
    for (var element in _returnedItems!) {
      items.add({
        "productId": element.productId ?? "",
        "variantId": element.variantId ?? "",
        "name": element.name ?? "",
        "image": (element.image ?? "").replaceAll('$BASE_IMG_URL/', ""),
        "price": element.price ?? "",
        "discount": element.discount ?? 0.0,
        "quantity": element.returnQuantity ?? 0,
        "orderQuantity": element.orderedQuantity,
      });
    }

    return json.encode(items);
  }

  ReturnScreenValidation();
}
