import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  String currentLanguage = "en";
  ThemeMode currentThemeMode = ThemeMode.dark;

  changeCurrentLanguage(String newLanguage) {
    if (currentLanguage == newLanguage) return;
    currentLanguage = newLanguage;
    notifyListeners();
  }

  changeCurrentTheme(ThemeMode newTheme) {
    if (currentThemeMode == newTheme) return;
    currentThemeMode = newTheme;
    notifyListeners();
  }

  String getBackgroundImage() {
    return currentThemeMode == ThemeMode.dark
        ? "assets/images/splash.png"
        : "assets/images/splash – 1.png";
  }

  bool isDark() {
    return (currentThemeMode == ThemeMode.dark);
  }

  bool isArabic() {
    return (currentLanguage == "en");
  }
}
