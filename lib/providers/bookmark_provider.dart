import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/bookmark_model.dart';

class BookmarkProvider with ChangeNotifier {
  final Map<String, Bookmark> _bookmarks = {};
  static const String _storageKey = 'bookmarks';

  Map<String, Bookmark> get bookmarks => Map.unmodifiable(_bookmarks);

  BookmarkProvider() {
    _loadBookmarks();
  }

  bool isBookmarked(int surahNumber, int ayahNumber) {
    final key = '${surahNumber}_$ayahNumber';
    return _bookmarks.containsKey(key);
  }

  void addBookmark(
    int surahNumber,
    int ayahNumber,
    String surahName,
    String ayahText,
    String translation,
  ) {
    final key = '${surahNumber}_$ayahNumber';
    final bookmark = Bookmark(
      id: key,
      surahNumber: surahNumber,
      ayahNumber: ayahNumber,
      surahName: surahName,
      ayahText: ayahText,
      translation: translation,
      createdAt: DateTime.now(),
    );

    _bookmarks[key] = bookmark;
    _saveBookmarks();
    notifyListeners();
  }

  void removeBookmark(int surahNumber, int ayahNumber) {
    final key = '${surahNumber}_$ayahNumber';
    _bookmarks.remove(key);
    _saveBookmarks();
    notifyListeners();
  }

  void clearAllBookmarks() {
    _bookmarks.clear();
    _saveBookmarks();
    notifyListeners();
  }

  Future<void> _loadBookmarks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bookmarksJson = prefs.getString(_storageKey);

      if (bookmarksJson != null) {
        final List<dynamic> bookmarksList = json.decode(bookmarksJson);
        _bookmarks.clear();

        for (final bookmarkJson in bookmarksList) {
          final bookmark = Bookmark.fromJson(bookmarkJson);
          final key = '${bookmark.surahNumber}_${bookmark.ayahNumber}';
          _bookmarks[key] = bookmark;
        }
        notifyListeners();
      }
    } catch (e) {
      // Error handling
    }
  }

  Future<void> _saveBookmarks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bookmarksList = _bookmarks.values.map((b) => b.toJson()).toList();
      final bookmarksJson = json.encode(bookmarksList);
      await prefs.setString(_storageKey, bookmarksJson);
    } catch (e) {
      // Error handling
    }
  }
}
