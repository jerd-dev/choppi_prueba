import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() =>
      ThemeData(
        useMaterial3: true, 
        appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF045cb4),
            titleTextStyle: TextStyle( 
              color: Colors.white,
              fontSize: 22
            ),
            iconTheme: IconThemeData(
              color: Colors.white
            )
        ),
        colorSchemeSeed: const Color(0xFF2862F5),
        scaffoldBackgroundColor: Colors.grey[300]
      );

  TextStyle subtitleTextStyle({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

}
