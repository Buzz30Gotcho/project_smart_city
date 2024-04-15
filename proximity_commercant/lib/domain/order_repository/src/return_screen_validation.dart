import 'dart:convert';
import 'package:proximity/proximity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:proximity_commercant/domain/order_repository/order_repository.dart';

class ReturnScreenValidation with ChangeNotifier {
  List<OrderItem>? _returnedItems = [];
  List<OrderItem>? get returnedItems => _returnedItems;

  String? _cardNumber = "";
  String? _expdate = "";
  String? _cvc = "";
  String? _name = "";
  String? _phone = "";
  String? _city = "";
  String? _street = "";
  String? _street2 = "";
  String? _postalCode = "";

  String? get cardNumber => _cardNumber;
  String? get expdate => _expdate;
  String? get cvc => _cvc;
  String? get name => _name;
  String? get phone => _phone;
  String? get city => _city;
  String? get street => _street;
  String? get street2 => _street2;
  String? get postalCode => _postalCode;

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

  double getTotalToRefund() {
    double refundTotal = 0.0;

    for (var element in _returnedItems!) {
      double returnPercentage = 0.0;
      if (element.policy != null && element.policy!.returnPolicy != null) {
        if (element.policy!.returnPolicy!.refund.order.percentage != null) {
          returnPercentage =
              element.policy!.returnPolicy!.refund.order.percentage ?? 0.0;
        } else if (element.policy!.returnPolicy!.refund.order.fixe != null) {
          returnPercentage =
              element.policy!.returnPolicy!.refund.order.fixe ?? 0.0;
        }
      }

      refundTotal +=
          element.price! * (element.returnQuantity ?? 0) * (returnPercentage);
    }

    return refundTotal;
  }

  ReturnScreenValidation.initProducts(List<OrderItem> new_products) {
    _returnedItems = [];
    _returnedItems!.addAll(new_products);
    notifyListeners();
  }
  String itemsToString() {
    print("im here");
    List<Map<String, dynamic>> items = [];
    try {
      _returnedItems!.forEach((element) {
        print("im here");
        print(element.policy == null);
        items.add({
          "productId": element.productId ?? "",
          "variantId": element.variantId ?? "",
          "name": element.name ?? "",
          "image": (element.image ?? "").replaceAll(BASE_IMG_URL + '/', ""),
          "price": element.price ?? "",
          "discount": element.discount ?? 0.0,
          "quantity": element.returnQuantity ?? 0,
          "orderQuantity": element.orderedQuantity,
          "policy": element.policy == null ? "null" : element.policy!.toJson()
        });
      });
    } catch (e) {
      print(e.toString());
    }

    print({"items": items, "total": getTotalToRefund()});

    Map<String, dynamic> request = {
      "items": items,
      "total": getTotalToRefund()
    };

    print(json.encode(request));
    return json.encode(request);
  }

  void changecardNumber(String value) {
    _cardNumber = value;
    notifyListeners();
  }

  void changeexpdate(String value) {
    if (value.length < 6) {
      if (value.length == 2 && _expdate!.length == 3) {
        _expdate = value.substring(0, 1);
      } else if (value.length == 2) {
        _expdate = value + "/";
      } else {
        _expdate = value;
      }
    }

    notifyListeners();
  }

  void changecvc(String value) {
    _cvc = value;
    notifyListeners();
  }

  void changename(String value) {
    _name = value;
    notifyListeners();
  }

  void changephone(String value) {
    _phone = value;
    notifyListeners();
  }

  void changecity(String value) {
    _city = value;
    notifyListeners();
  }

  void changestreet(String value) {
    _street = value;
    notifyListeners();
  }

  void changestreet2(String value) {
    _street2 = value;
    notifyListeners();
  }

  void changepostalCode(String value) {
    _postalCode = value;
    notifyListeners();
  }

  bool isFormValid() {
    int allReturnedQuantity = 0;
    for (var element in _returnedItems!) {
      allReturnedQuantity += (element.returnQuantity ?? 0);
    }
    if (allReturnedQuantity == 0) return false;

    return true;
  }

  ReturnScreenValidation();
}
