import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';

enum AppThemeMode { light, dark, viu }

class ThemeNotifier extends Notifier<ThemeData> {
  AppThemeMode _mode = AppThemeMode.viu;

  AppThemeMode get currentMode => _mode;

  @override
  ThemeData build() {
    return _getThemeForMode(_mode); // se asegura que el tema inicial sea el correcto
  }

  void setTheme(AppThemeMode mode) {
    _mode = mode;
    state = _getThemeForMode(mode); // aplica el nuevo tema
  }

  ThemeData _getThemeForMode(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return AppTheme.light;
      case AppThemeMode.dark:
        return AppTheme.dark;
      case AppThemeMode.viu:
        return AppTheme.viu;
    }
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeData>(() => ThemeNotifier());
