// lib/core/theme/dark_theme.dart
import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Color(0xFF132848),
  scaffoldBackgroundColor: Color(0xFF101725),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF1E2C3C),
    foregroundColor: Colors.white,
  ),
  cardColor: Color.fromARGB(255, 36, 68, 105),
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white70),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF132848),
      foregroundColor: Colors.white,
    ),
  ),
  iconTheme: IconThemeData(
    color: Color.fromARGB(255, 255, 255, 255),  
    size: 30,
  ),
);