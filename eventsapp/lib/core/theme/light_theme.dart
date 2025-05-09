// lib/core/theme/light_theme.dart
import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color(0xFF34C8A1),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    elevation: 0,
  ),
  cardColor: Color(0xFFF8F8F8),
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF34C8A1),
      foregroundColor: Colors.white,
    ),
  ),
);