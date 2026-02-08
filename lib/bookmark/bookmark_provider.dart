import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Required for jsonEncode and jsonDecode

class BookmarkProvider with ChangeNotifier {
  List<Map<String, String>> _bookmarks = [];

  List<Map<String, String>> get bookmarks => _bookmarks;

  BookmarkProvider() {
    _loadBookmarks(); // Load saved data as soon as the app starts
  }

  // Save to local storage
  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    // Convert the List of Maps into a JSON string
    String encodedData = jsonEncode(_bookmarks);
    await prefs.setString('user_bookmarks', encodedData);
  }

  // Load from local storage
  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedData = prefs.getString('user_bookmarks');

    if (savedData != null) {
      // Decode the JSON string back into a List of Maps
      List<dynamic> decodedData = jsonDecode(savedData);
      _bookmarks = decodedData
          .map((item) => Map<String, String>.from(item))
          .toList();
      notifyListeners();
    }
  }

  void toggleBookmark(Map<String, String> material) {
    final index = _bookmarks.indexWhere(
      (m) =>
          m['title'] == material['title'] &&
          m['chapter'] == material['chapter'],
    );

    if (index >= 0) {
      _bookmarks.removeAt(index);
    } else {
      _bookmarks.add(material);
    }

    _saveToPrefs(); // Save changes to the phone's memory
    notifyListeners();
  }

  bool isBookmarked(String title, String chapter) {
    return _bookmarks.any(
      (m) => m['title'] == title && m['chapter'] == chapter,
    );
  }
}
