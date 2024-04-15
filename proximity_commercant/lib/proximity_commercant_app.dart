import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:proximity/l10n/l10n.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/data_persistence/src/boxes.dart';
import 'package:proximity_commercant/domain/user_repository/user_repository.dart';
import 'package:proximity_commercant/ui/pages/authentication_pages/view/onBoard.dart';
import 'package:proximity_commercant/ui/pages/onBoarding_page/OnBoardingScreen.dart';
//import 'package:proximity_commercant/ui/pages/pages.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class ProximityCommercantApp extends StatefulWidget {
  const ProximityCommercantApp({Key? key}) : super(key: key);

  @override
  State<ProximityCommercantApp> createState() => _ProximityCommercantAppState();
}

class _ProximityCommercantAppState extends State<ProximityCommercantApp> {
  @override
  void initState() {
    super.initState();
    initPlatform();
  }

  //String _debugLabelString = "";
  //BuildContext? _context = null;

  @override
  Widget build(BuildContext context) {
    /// User Settings
    final userSettings = Provider.of<UserSettings>(context);
    var credentialsBox = Boxes.getCredentials();
    bool isFirstTime = credentialsBox.get('first_time', defaultValue: true);

    /// Changing the StatusBar and NavigationBar in Andorid
    bool themeIsDark = userSettings.theme == 'dark';
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: themeIsDark
            ? scaffoldBackgroundDarkColor
            : scaffoldBackgroundLightColor,
        statusBarColor: Colors.transparent));

    return MaterialApp(
        title: 'Proximity Commercant App',
        theme: userSettings.theme == 'dark' ? darkTheme : lightTheme,
        darkTheme: userSettings.theme == 'light' ? lightTheme : darkTheme,
        locale: userSettings.locale,
        supportedLocales: locales,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: isFirstTime ? OnBoardingScreen() : OnBoard()
        //for testing
        //home: const SignupScreen()
        );
  }

  Future<void> initPlatform() async {
    // await OneSignal.shared.setRequiresUserPrivacyConsent(true);
    // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission

    OneSignal.User.pushSubscription.addObserver((changes) {
      print("SUBSCRIPTION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    OneSignal.User.addObserver((changes) {
      print("PERMISSION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    OneSignal.initialize("647f5e0b-0643-4098-a451-0cbce475e3af");
    await OneSignal.Notifications.permissionNative()
        .then((accepted) {
      print("Accepted permission: $accepted");
    });
  }
}
