import 'package:flutter/material.dart';
import 'package:tamenny_app/config/cache_helper.dart';

import 'package:tamenny_app/core/theme/app_colors.dart';

class ThemeNotifier extends ChangeNotifier {
  static const String _themeKey = 'isDarkMode';
  bool _isDark = false;

  bool get isDark => _isDark;

  ThemeData get currentTheme => _isDark ? darkTheme : lightTheme;

  ThemeNotifier() {
    loadThemeFromPrefs(); // Load saved theme on init
  }

  void toggleTheme() async {
    _isDark = !_isDark;
    notifyListeners();
    _saveThemeToPrefs();
  }

  void setDarkMode(bool value) {
    _isDark = value;
    notifyListeners();
    _saveThemeToPrefs();
  }

  Future<void> loadThemeFromPrefs() async {
    _isDark = CacheHelper.getBool(key: _themeKey) ?? false;
    notifyListeners();
  }

  Future<void> _saveThemeToPrefs() async {
    await CacheHelper.set(key: _themeKey, value: _isDark);
  }
}

final ThemeData darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor:
      AppColors.darkBackgroundColor, // Dark screen background
  primaryColor: AppColors.darkPrimaryColor, // Primary accent in dark mode
  cardColor: AppColors.darkCardColor, // Background for cards and containers
  dividerColor: AppColors.darkDividerColor, // For lines/separators

  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.darkBackgroundColor, // App bar background
    foregroundColor: Colors.white, // App bar text/icon color
    iconTheme: IconThemeData(color: Colors.white), // App bar icons
  ),

  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.darkTextColor), // Main text
    bodyMedium:
        TextStyle(color: AppColors.darkSecondaryTextColor), // Secondary text
    titleLarge: TextStyle(color: AppColors.darkTextColor),
  ),

  iconTheme:
      const IconThemeData(color: AppColors.darkTextColor), // Default icon color

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.darkCardColor,
    selectedItemColor: AppColors.darkPrimaryColor,
    unselectedItemColor: AppColors.darkSecondaryTextColor,
  ),

  // Optional: Customize switches, sliders, etc.
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all(AppColors.darkPrimaryColor),
    trackColor:
        WidgetStateProperty.all(AppColors.darkPrimaryColor.withOpacity(0.4)),
  ),
);

final ThemeData lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: AppColors.grayColor,
  primaryColor: AppColors.primaryColor,
  cardColor: Colors.white,
  dividerColor: AppColors.deepGrayColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.grayColor,
    foregroundColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.black),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black87),
    titleLarge: TextStyle(color: Colors.black),
  ),
  iconTheme: const IconThemeData(color: Colors.black),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: AppColors.primaryColor,
    unselectedItemColor: Colors.grey,
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all(AppColors.primaryColor),
    trackColor:
        WidgetStateProperty.all(AppColors.primaryColor.withOpacity(0.4)),
  ),
);
