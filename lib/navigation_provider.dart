import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationProvider with ChangeNotifier {
  int _currentIndex = 0;
  Locale _locale = const Locale('en');

  int get currentIndex => _currentIndex;
  Locale get locale => _locale;

  NavigationProvider() {
    _loadLocale(); // Load saved language on startup
  }

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void setLocale(Locale newLocale) async {
    _locale = newLocale;
    notifyListeners();

    // Save to local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', newLocale.languageCode);
  }

  void _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    String code = prefs.getString('language_code') ?? 'en';
    _locale = Locale(code);
    notifyListeners();
  }
}
