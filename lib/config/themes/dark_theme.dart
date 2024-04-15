import 'package:flutter/material.dart';
import 'package:proximity/config/colors.dart';
import 'package:proximity/config/themes/text_themes.dart';
import 'package:proximity/config/values.dart';

final ThemeData darkTheme = ThemeData(
    primarySwatch: blueSwatch,

    /// brightness
    brightness: Brightness.dark,

    /// primary and accent colors
    primaryColor: blueSwatch.shade500,
    primaryColorLight: blueSwatch.shade300,
    primaryColorDark: blueSwatch.shade700,
    //primaryColorBrightness: Brightness.dark,

    /// body colors
    canvasColor: scaffoldBackgroundDarkColor,
    backgroundColor: scaffoldBackgroundDarkColor,
    scaffoldBackgroundColor: scaffoldBackgroundDarkColor,
    dialogBackgroundColor: scaffoldBackgroundDarkColor,
    cardColor: cardBackgroundDarkColor,
    dividerColor: dividerDarkColor,
    disabledColor: disabledDarkColor,
    shadowColor: Colors.black.withOpacity(0.3),

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
            side: BorderSide(color: dividerDarkColor, width: tiny_50),
            borderRadius: BorderRadius.all(smallRadius))),

    /// iconTheme
    iconTheme: const IconThemeData(color: primaryTextDarkColor, size: normal_200),
    primaryIconTheme: IconThemeData(color: blueSwatch.shade500, size: normal_200),

    /// chipTheme
    chipTheme: const ChipThemeData(
      side: BorderSide(width: tiny_50, color: dividerDarkColor),
      backgroundColor: cardBackgroundDarkColor,
    ),

    /// dividerTheme
    dividerTheme: const DividerThemeData(thickness: tiny_50, space: normal_100),

    /// buttonThemes
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: blueSwatch.shade500,
    ),
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
          return disabledTextDarkColor;
        }
        return null;
      }),
      animationDuration: normalAnimationDuration,
      side: MaterialStateProperty.all<BorderSide>(
          const BorderSide(width: tiny_50, color: Colors.transparent)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(smallRadius))),
      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(
          vertical: normal_100, horizontal: normal_150)),
    )),
    // Secondary Button
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
      elevation: MaterialStateProperty.all<double>(small_100),
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return blueSwatch.shade500.withOpacity(0.3);
        } else if (states.contains(MaterialState.disabled)) {
          return disabledDarkColor;
        }
        return cardBackgroundDarkColor;
      }),
      overlayColor: MaterialStateProperty.all<Color>(dividerDarkColor),
      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return disabledTextDarkColor;
        }
        return primaryTextDarkColor;
      }),
      animationDuration: normalAnimationDuration,
      side: MaterialStateProperty.resolveWith<BorderSide?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return BorderSide(width: tiny_50, color: blueSwatch.shade500);
        } else if (states.contains(MaterialState.disabled)) {
          return const BorderSide(width: tiny_50, color: disabledTextDarkColor);
        }
        return const BorderSide(width: tiny_50, color: dividerDarkColor);
      }),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(smallRadius))),
      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(
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
          return disabledTextDarkColor;
        } else {
          return blueSwatch.shade500;
        }
      }),
      animationDuration: normalAnimationDuration,
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(smallRadius))),
      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(
          vertical: normal_100, horizontal: normal_150)),
    )),

    /// textTheme
    textTheme: darkTextTheme,

    /// textInputTheme
    textSelectionTheme:
        TextSelectionThemeData(cursorColor: blueSwatch.shade500),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: darkTextTheme.subtitle2!
          .copyWith(color: secondaryTextDarkColor, fontWeight: FontWeight.w600),
      border: const OutlineInputBorder(
          borderSide: BorderSide(width: 0, style: BorderStyle.none)),
      contentPadding: const EdgeInsets.symmetric(horizontal: normal_100),
      constraints: const BoxConstraints(minHeight: normal_300),
      prefixIconColor: secondaryTextDarkColor,
      suffixIconColor: secondaryTextDarkColor,
      focusColor: blueSwatch.shade500,
    ));
