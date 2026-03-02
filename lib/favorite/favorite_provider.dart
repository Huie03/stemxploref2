import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoriteProvider with ChangeNotifier {
  List<Map<String, String>> _favorites = [];

  List<Map<String, String>> get bookmarks => _favorites;

  FavoriteProvider() {
    _loadFavorites();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    String encodedData = jsonEncode(_favorites);
    await prefs.setString('user_favorites', encodedData);
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedData = prefs.getString('user_favorites');

    if (savedData != null) {
      List<dynamic> decodedData = jsonDecode(savedData);
      _favorites = decodedData
          .map((item) => Map<String, String>.from(item))
          .toList();
      notifyListeners();
    }
  }

  void toggleFavorite(Map<String, String> material) {
    final index = _favorites.indexWhere(
      (m) =>
          m['title'] == material['title'] &&
          m['chapter_num'] == material['chapter_num'],
    );

    if (index >= 0) {
      _favorites.removeAt(index);
    } else {
      _favorites.add(material);
    }

    _saveToPrefs();
    notifyListeners();
  }

  bool isFavorited(String title, String chapterNum) {
    return _favorites.any(
      (m) => m['title'] == title && m['chapter_num'] == chapterNum,
    );
  }
}
