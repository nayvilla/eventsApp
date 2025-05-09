// lib/core/providers/theme_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';

enum AppThemeMode { light, dark, viu }

class ThemeNotifier extends Notifier<ThemeData> {
  AppThemeMode _mode = AppThemeMode.light;

  AppThemeMode get currentMode => _mode;

  @override
  ThemeData build() {
    return AppTheme.light;
  }

  void setTheme(AppThemeMode mode) {
    _mode = mode;
    switch (mode) {
      case AppThemeMode.light:
        state = AppTheme.light;
        break;
      case AppThemeMode.dark:
        state = AppTheme.dark;
        break;
      case AppThemeMode.viu:
        state = AppTheme.viu;
        break;
    }
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeData>(() => ThemeNotifier());