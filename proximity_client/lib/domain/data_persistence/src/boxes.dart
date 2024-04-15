import 'package:hive/hive.dart';
import 'package:proximity_client/domain/cart_repository/cart_repository.dart';
import 'package:proximity_client/domain/product_repository/product_repository.dart';

class Boxes {
  static Box getCredentials() => Hive.box('credentials');

  static Box<Cart> getCartBox() => Hive.box<Cart>('cart');

  static Box<CartItem> getCartItemsBox() => Hive.box<CartItem>('cart_items');

  static Box<WishlistItem> getWishlist() => Hive.box<WishlistItem>('wishlist');

  static Box getSettingsBox() => Hive.box('settings');
}
