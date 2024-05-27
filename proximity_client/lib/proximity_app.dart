import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:proximity/l10n/l10n.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/user_repository/user_repository.dart';
import 'package:proximity_client/ui/pages/main_pages/view/onBoard.dart';
//import 'package:proximity_client/ui/pages/main_pages/view/welcomeScreen.dart';
import 'package:proximity_client/ui/pages/pages.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:proximity_client/domain/store_repository/store_repository.dart';

import 'domain/data_persistence/src/boxes.dart';

import 'package:uni_links/uni_links.dart';
//import 'package:flutter/services.dart' show PlatformException;

final GlobalKey<NavigatorState> myWidgetKey = GlobalKey<NavigatorState>();

final GlobalKey<_ProximityAppState> myWidgetKey2 =
    GlobalKey<_ProximityAppState>();

class ProximityApp extends StatefulWidget {
  const ProximityApp({Key? key}) : super(key: key);

  @override
  State<ProximityApp> createState() => _ProximityAppState();
}

class _ProximityAppState extends State<ProximityApp> {
  @override
  void initState() {
    super.initState();
    initPlatform();
    initUniLinks();
  }

  Future<void> initUniLinks() async {
    try {
      final initialLink = await getInitialLink();
      handleDeepLink(Uri.parse(initialLink ?? ""));
    } on Exception catch (e) {
      print('Error initializing uni_links: $e');
    }

    uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        handleDeepLink(uri);
      }
    });
  }

  void handleDeepLink(Uri uri) {
    print("uri");
    List<String> charArray = uri.path.split('/');
    if (charArray.length > 2) {
      switch (charArray[1]) {
        case "product":
          myWidgetKey.currentState!.push(MaterialPageRoute(
              builder: (context) => ProductScreen(id: charArray[2])));
          break;
        case "store":
          final storeProxy = Provider.of<StoreProxy>(context, listen: false);
          storeProxy.idStore = charArray[2];
          myWidgetKey.currentState!.push(
              MaterialPageRoute(builder: (context) => const StoreScreen()));
          break;
        default:
      }
    }
    return;
    // Parse the uri and navigate to the appropriate screen in your app.
    // Example: you can extract query parameters to determine the action.
    // Navigator.push(context, MaterialPageRoute(builder: (context) => MyScreen()));
  }

  @override
  Widget build(BuildContext context) {
    var credentialsBox = Boxes.getCredentials();
    bool isFirstTime = credentialsBox.get('first_time', defaultValue: true);

    /// User Settings
    final userSettings = Provider.of<UserSettings>(context);

    /// Changing the StatusBar and NavigationBar in Andorid
    bool themeIsDark = userSettings.theme == 'dark';
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: scaffoldBackgroundLightColor,
        //systemNavigationBarColor: themeIsDark ? scaffoldBackgroundDarkColor : scaffoldBackgroundLightColor,

        // systemNavigationBarColor: themeIsDark
        //    ? scaffoldBackgroundDarkColor
        //  : scaffoldBackgroundLightColor,
        statusBarColor: Colors.transparent));

    return MaterialApp(
        key: myWidgetKey2,
        navigatorKey: myWidgetKey,
        title: 'Proximity App',
        theme:themeIsDark?darkTheme: lightTheme, // CHANGEMENT DARK THEME OK
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        //theme: userSettings.theme == 'dark' ? darkTheme : lightTheme,
        //darkTheme: userSettings.theme == 'light' ? lightTheme : darkTheme,
        locale: userSettings.locale,
        supportedLocales: locales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: const OnBoard());
  }

  Future<void> initPlatform() async {
    // await OneSignal.shared.setRequiresUserPrivacyConsent(true);
    // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission

    OneSignal.User.pushSubscription
    .addObserver((OSPushSubscriptionChangedState changes) {
      print("SUBSCRIPTION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    OneSignal.User.addObserver((changes) {
      print("PERMISSION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    OneSignal.initialize("647f5e0b-0643-4098-a451-0cbce475e3af");
    await OneSignal.Notifications.permissionNative()
        //.promptUserForPushNotificationPermission()
        .then((accepted) {
      print("Accepted permission: $accepted");
    });
  }
}
