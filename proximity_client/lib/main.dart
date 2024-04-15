import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proximity_client/CustomErrorWidget.dart';
import 'package:proximity_client/domain/authentication/authentication.dart';
import 'package:proximity_client/domain/cart_repository/cart_repository.dart';
import 'package:proximity_client/domain/order_repository/order_repository.dart';
import 'package:proximity_client/domain/product_repository/product_repository.dart';
import 'package:proximity_client/domain/store_repository/store_repository.dart';
import 'package:proximity_client/domain/user_repository/models/address_item_model.dart';
import 'package:proximity_client/domain/user_repository/user_repository.dart';
import 'package:proximity_client/domain/notification_repository/notification_repository.dart';

import 'proximity_app.dart';

void main() async {
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  WidgetsFlutterBinding.ensureInitialized();
  //Safa:
  await Hive.initFlutter();

  Hive.registerAdapter(CartItemAdapter());
  Hive.registerAdapter(CartAdapter());
  Hive.registerAdapter(WishlistItemAdapter());
  Hive.registerAdapter(AddressItemAdapter());

  /// Credentials are to store [Access Token]
  await Hive.openBox('credentials');
  await Hive.openBox<Cart>('cart');
  await Hive.openBox<CartItem>('cart_items');
  await Hive.openBox<WishlistItem>('wishlist');
  await Hive.openBox<AddressItem>('address');
  await Hive.openBox<bool>('first_time');

  /// Settings are to store user settings and preferences
  await Hive.openBox('settings');

  /// Google Maps Android Hybrid Composition
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  ErrorWidget.builder = (error) => CustomErrorWidget(
        error: error,
      );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => LoginValidation()),
    ChangeNotifierProvider(create: (_) => SignupValidation()),
    ChangeNotifierProvider(create: (_) => OTPValidation()),
    ChangeNotifierProvider(create: (_) => UserService()),
    ChangeNotifierProxyProvider<LoginValidation, UserService>(
        create: (_) => UserService(),
        update: (_, __, UserService) => UserService!..getUserData()),
    ChangeNotifierProxyProvider<OTPValidation, UserService>(
        create: (_) => UserService(),
        update: (_, __, UserService) => UserService!..getUserData()),
    ChangeNotifierProvider(create: (_) => ProductService()),
    ChangeNotifierProvider(create: (_) => StoreProxy()),
    ChangeNotifierProvider(create: (_) => ResetPasswordValidation()),
    ChangeNotifierProxyProvider<StoreProxy, StoreService>(
        create: (_) => StoreService(),
        update: (_, __, storeService) =>
            storeService!..loadStore(Provider.of<StoreProxy>(_))),
    ChangeNotifierProvider(create: (_) => OrderService()),
    ChangeNotifierProvider(create: (context) => CartService()),
    ChangeNotifierProvider(create: (_) => WishlistService()),
    ChangeNotifierProvider(create: (_) => ShareService()),
    ChangeNotifierProvider(create: (context) => UserSettings()),
    ChangeNotifierProvider(create: (_) => NotificationService()),
  ], child: const ProximityApp()));
}
