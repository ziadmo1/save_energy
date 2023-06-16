
import 'package:flutter/material.dart';

class MyTheme {

  static const Color navyBlue = Color(0xFF2c344e);
  static  ThemeData theme = ThemeData(
    scaffoldBackgroundColor: navyBlue,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: navyBlue,
      iconTheme: IconThemeData(
        color: Colors.white
      ),
      titleTextStyle: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: Colors.white
      )
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: navyBlue
      ),
        labelLarge: TextStyle(
        fontSize: 37,
        fontWeight: FontWeight.bold,
        color: Colors.white
      ),
        titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: navyBlue
      ),
        bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.black
      )
    )
  );
}