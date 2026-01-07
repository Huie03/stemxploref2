import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeData get currentTheme => _isDarkMode ? darkTheme : lightTheme;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners(); // This tells the whole app to rebuild
  }

  // Define your Light Theme
  static final lightTheme = ThemeData(
    primarySwatch: Colors.orange,
    scaffoldBackgroundColor: const Color(0xFFF7E7C3),
    brightness: Brightness.light,
  );

  // Define your Dark Theme
  static final darkTheme = ThemeData(
    primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: const Color(0xFF121212),
    brightness: Brightness.dark,
    // Add specific dark mode styles here
    textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.white)),
  );
}
