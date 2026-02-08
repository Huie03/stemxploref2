import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'stem_highlights/highlight.dart'; // Ensure this path is correct

class NavigationProvider with ChangeNotifier {
  int _currentIndex = 0;
  Locale _locale = const Locale('en');

  // 1. Define the private variable
  Highlight? _selectedHighlight;

  int get currentIndex => _currentIndex;
  Locale get locale => _locale;

  // 2. Define the getter (Fixes the MainScreen error)
  Highlight? get selectedHighlight => _selectedHighlight;

  NavigationProvider() {
    _loadLocale();
  }

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  // 3. Method to set the highlight and switch to index 10
  void openHighlight(Highlight highlight) {
    _selectedHighlight = highlight;
    _currentIndex = 10;
    notifyListeners();
  }

  void setLocale(Locale newLocale) async {
    _locale = newLocale;
    notifyListeners();
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
