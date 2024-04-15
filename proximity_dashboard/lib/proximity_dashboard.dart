import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity/l10n/l10n.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:proximity_dashboard/pages/login_screen.dart';
//import 'package:proximity_dashboard/pages/pages.dart';

class ProximityDashboardApp extends StatelessWidget {
  const ProximityDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// Changing the StatusBar and NavigationBar in Andorid
    // bool themeIsDark = userSettings.theme == 'dark';
    bool themeIsDark = true;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor:
        themeIsDark ? scaffoldBackgroundDarkColor : scaffoldBackgroundLightColor,
        statusBarColor: Colors.transparent));

    return MaterialApp(
      title: 'Proximity Dashboard',
      theme: darkTheme,
      darkTheme: darkTheme,
      locale: const Locale('en', 'UK'),
      supportedLocales: locales,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: const LoginScreen(),
    );
  }
}
