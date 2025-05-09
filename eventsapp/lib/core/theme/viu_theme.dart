// lib/core/theme/viu_theme.dart
import 'package:flutter/material.dart';

final viuTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color(0xFFFF6B00),
  scaffoldBackgroundColor: Color(0xFFFDF6F0),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
  ),
  cardColor: Color(0xFFFDF6F0),
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.black),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFFFF6B00),
      foregroundColor: Colors.white,
    ),
  ),
);