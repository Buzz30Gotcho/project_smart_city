import 'package:flutter/material.dart';

/// This provider is necessary for the ProductService ChangeNotifierProxyProvider
/// it updates the selected Shop whenever we select a new shop
class StoreProxy with ChangeNotifier {
  late String _idStore;

  String get idStore => _idStore;

  set idStore(String newIdStore) {
    _idStore = newIdStore;
    notifyListeners();
  }

  StoreProxy() {
    _idStore = '';
  }
}
