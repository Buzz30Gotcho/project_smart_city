import 'package:flutter/material.dart';

class ProductModalController extends ChangeNotifier {
  String? _productVariantId;
  late int _quantity;

  String? get productVariantId => _productVariantId;

  int get quantity => _quantity;

  ProductModalController(String? variantId) {
    _productVariantId = variantId;
    _quantity = 1;
  }

  void selectVariant(String productVariantId) {
    _productVariantId = productVariantId;
    notifyListeners();
  }

  void increaseQuantity() {
    _quantity++;
    notifyListeners();
  }

  void decreaseQuantity() {
    if (_quantity > 0) {
      _quantity--;
      notifyListeners();
    }
  }

  bool valid() {
    return (quantity > 0) && (_productVariantId != null);
  }
}
