import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:proximity_commercant/domain/authentication/authentication.dart';
import 'package:proximity_commercant/domain/authentication/src/reset_password_validation.dart';
import 'package:proximity_commercant/domain/order_repository/order_repository.dart';
import 'package:proximity_commercant/domain/product_repository/product_repository.dart';

import 'package:proximity_commercant/domain/store_repository/src/policy_creation_validation.dart';
import 'package:proximity_commercant/domain/store_repository/store_repository.dart';
import 'package:proximity_commercant/domain/user_repository/user_repository.dart';
import 'package:proximity_commercant/CustomErrorWidget.dart';
//import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:proximity_commercant/domain/notification_repository/notification_repository.dart';

import 'domain/statistic_repository/src/Statistic_service.dart';
import 'proximity_commercant_app.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  /// Credentials are to store [Access Token]
  await Hive.openBox('credentials');
  //welcone
  await Hive.openBox('welcome');

  /// Settings are to store user settings and preferences
  await Hive.openBox('settings');
  await Hive.openBox('onboardingBox');

  /// Google Maps Android Hybrid Composition
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }

  ErrorWidget.builder = (error) => CustomErrorWidget();
  //Remove this method to stop OneSignal Debugging

  runApp(Phoenix(
    child: MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => LoginValidation()),
      ChangeNotifierProvider(create: (_) => ResetPasswordValidation()),
      ChangeNotifierProvider(create: (_) => SignupValidation()),
      ChangeNotifierProvider(create: (_) => OTPValidation()),
      ChangeNotifierProvider(create: (_) => UserService()),
      ChangeNotifierProvider(create: (_) => PolicyValidation()),
      ChangeNotifierProvider(create: (_) => StoreCreationValidation()),
      ChangeNotifierProvider(create: (_) => ProductCreationValidation()),
      ChangeNotifierProxyProvider<LoginValidation, UserService>(
          create: (_) => UserService(),
          update: (_, __, UserService) => UserService!..getUserData()),
      ChangeNotifierProxyProvider<OTPValidation, UserService>(
          create: (_) => UserService(),
          update: (_, __, UserService) => UserService!..getUserData()),
      ChangeNotifierProvider(create: (_) => ProductCreationValidation()),
      ChangeNotifierProvider(create: (_) => StoreService()),
      ChangeNotifierProvider(create: (_) => StatisticService()),
      ChangeNotifierProvider(create: (_) => ProductProxy()),
      ChangeNotifierProxyProvider<ProductProxy, ProductService>(
          create: (_) => ProductService(),
          update: (_, __, productService) =>
              productService!..reloadList(Provider.of<ProductProxy>(_))),
      ChangeNotifierProvider(create: (_) => OrderService()),
      ChangeNotifierProvider(create: (_) => UserSettings()),
      ChangeNotifierProvider(create: (_) => NotificationService()),
    ], child: const ProximityCommercantApp()),
  ));
}
