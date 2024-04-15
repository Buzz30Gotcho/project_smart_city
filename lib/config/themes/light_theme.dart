import 'package:flutter/material.dart';
import 'package:proximity/config/colors.dart';
import 'package:proximity/config/themes/text_themes.dart';
import 'package:proximity/config/values.dart';

final ThemeData lightTheme = ThemeData(
    primarySwatch: blueSwatch,

    /// brightness
    brightness: Brightness.light,

    /// primary and accent colors
    primaryColor: blueSwatch.shade500,
    primaryColorLight: blueSwatch.shade300,
    primaryColorDark: blueSwatch.shade700,
    //primaryColorBrightness: Brightness.light,

    /// body colors
    canvasColor: scaffoldBackgroundLightColor,
    backgroundColor: scaffoldBackgroundLightColor,
    scaffoldBackgroundColor: scaffoldBackgroundLightColor,
    dialogBackgroundColor: scaffoldBackgroundLightColor,
    cardColor: cardBackgroundLightColor,
    dividerColor: dividerLightColor,
    disabledColor: disabledLightColor,
    shadowColor: primaryTextLightColor.withOpacity(0.3),

    /// interaction colors
    highlightColor: const Color(0x66bcbcbc),
    splashColor: const Color(0x66c8c8c8),
    //selectedRowColor: const Color(0xfff5f5f5),
    unselectedWidgetColor: const Color(0x8a000000),
    toggleableActiveColor: blueSwatch.shade700,
    secondaryHeaderColor: blueSwatch.shade50,
    indicatorColor: blueSwatch.shade300,
    hintColor: const Color(0x8a000000),
    errorColor: redSwatch.shade500,

    /// cardTheme
    cardTheme: const CardTheme(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: dividerLightColor, width: tiny_50),
            borderRadius: BorderRadius.all(smallRadius))),

    /// iconTheme
    iconTheme: const IconThemeData(color: primaryTextLightColor, size: normal_200),
    primaryIconTheme: IconThemeData(color: blueSwatch.shade500, size: normal_200),

    /// dividerTheme
    dividerTheme: const DividerThemeData(thickness: tiny_50, space: normal_100),

    /// buttonThemes
    // Primary Button
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(small_100),
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (!states.contains(MaterialState.disabled)) {
                  return blueSwatch.shade500;
                }
                return null; // Defer to the widget's default.
              }),
          overlayColor: MaterialStateProperty.all<Color>(blueSwatch.shade700),
          foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return disabledTextLightColor;
                }
                return null;
              }),
          animationDuration: normalAnimationDuration,
          side: MaterialStateProperty.all<BorderSide>(
              const BorderSide(width: tiny_50, color: Colors.transparent)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(smallRadius))),
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(
                  vertical: normal_100, horizontal: normal_150)),
        )),
    // Secondary Button
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0),
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return blueSwatch.shade500.withOpacity(0.3);
                } else if (states.contains(MaterialState.disabled)) {
                  return disabledLightColor;
                }
                return cardBackgroundLightColor;
              }),
          overlayColor: MaterialStateProperty.all<Color>(dividerLightColor),
          foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return disabledTextLightColor;
                }
                return primaryTextLightColor;
              }),
          animationDuration: normalAnimationDuration,
          side: MaterialStateProperty.resolveWith<BorderSide?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return BorderSide(width: tiny_50, color: blueSwatch.shade500);
                } else if (states.contains(MaterialState.disabled)) {
                  return const BorderSide(
                      width: tiny_50, color: disabledTextLightColor);
                }
                return const BorderSide(width: tiny_50, color: dividerLightColor);
              }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(smallRadius))),
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(
                  vertical: normal_100, horizontal: normal_150)),
        )),
    // Tertiary Button
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(
              blueSwatch.shade500.withOpacity(0.3)),
          foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return disabledTextLightColor;
                } else {
                  return blueSwatch.shade500;
                }
              }),
          animationDuration: normalAnimationDuration,
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(smallRadius))),
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(
                  vertical: normal_100, horizontal: normal_150)),
        )),

    /// textTheme
    textTheme: lightTextTheme,

    /// textInputTheme
    textSelectionTheme: TextSelectionThemeData(cursorColor: blueSwatch.shade500),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: darkTextTheme.subtitle2!.copyWith(color: secondaryTextLightColor, fontWeight: FontWeight.w600),
      border: const OutlineInputBorder(
          borderSide: BorderSide(width: 0, style: BorderStyle.none)),
      contentPadding: const EdgeInsets.symmetric(horizontal: normal_100),
      constraints: const BoxConstraints(minHeight: normal_300),
      prefixIconColor: secondaryTextLightColor,
      suffixIconColor: secondaryTextLightColor,
      focusColor: blueSwatch.shade500,
    ));