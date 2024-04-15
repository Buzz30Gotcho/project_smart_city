import 'package:flutter/material.dart';
import 'package:proximity_client/domain/data_persistence/data_persistence.dart';
import 'package:proximity_client/domain/product_repository/product_repository.dart';

class WishlistService with ChangeNotifier {
  // Hive box
  var wishlistBox;

  // constructor
  WishlistService() {
    /// Hive box
    wishlistBox = Boxes.getWishlist();
  }

  bool contains(String key) {
    return wishlistBox.containsKey(key);
  }

  /// POST methods
  Future addToWishlist(bool value, Product product) async {
    // if value is true, then add it to the [Wishlist]
    if (value) {
      final WishlistItem wishlistItem = WishlistItem.fromProduct(product);
      wishlistBox.put(wishlistItem.id, wishlistItem);
    }
    // if already on [Wishlist] then delete it
    else {
      wishlistBox.delete(product.id);
    }
    notifyListeners();
  }
}
