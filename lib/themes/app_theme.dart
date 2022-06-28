import 'package:flutter/material.dart';

class AppTheme {
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF00ADB5,
    <int, Color>{
      50: Color(0xFFE0F5F6),
      100: Color(0xFFB3E6E9),
      200: Color(0xFF80D6DA),
      300: Color(0xFF4DC6CB),
      400: Color(0xFF26B9C0),
      500: Color(0xFF00ADB5),
      600: Color(0xFF00A6AE),
      700: Color(0xFF009CA5),
      800: Color(0xFF00939D),
      900: Color(0xFF00838D),
    },
  );

  static const primaryColor = Color(0xFF00ADB5);
  static const accentColor = Color(0xFF222831);
  static const lightColor = Color(0xFFEEEEEE);

  static ThemeData get light {
    return ThemeData(
      primaryColor: primaryColor,
      // ignore: deprecated_member_use
      accentColor: primaryColor, // for month picker dialog
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: primarySwatch,
        accentColor: accentColor,
      ).copyWith(secondary: accentColor),
      scaffoldBackgroundColor: primaryColor,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: accentColor,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              width: 1.0,
              color: AppTheme.primaryColor,
              style: BorderStyle.solid),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              width: 2.0,
              color: AppTheme.primaryColor,
              style: BorderStyle.solid),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
          // backgroundColor: accentColor,
          // behavior: SnackBarBehavior.floating,
          ),
    );
  }

  static ThemeData get dark {
    return ThemeData.dark();
  }
}
