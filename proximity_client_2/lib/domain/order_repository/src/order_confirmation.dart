import 'package:flutter/material.dart';
import 'package:proximity_client/domain/store_repository/models/models.dart';

class OrderConfirmation extends ChangeNotifier {
  ShippingMethod? _shippingMethod;

  // Getters
  ShippingMethod? get shippingMethod => _shippingMethod;

  // Setters
  void changeShippingMethod(ShippingMethod shippingMethod) {
    _shippingMethod = shippingMethod;
    notifyListeners();
  }

  OrderConfirmation();
}
