import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/bookmark_model.dart';

class BookmarkService {
  static const String _bookmarksKey = 'bookmarks';

  // Get all bookmarks
  Future<List<Bookmark>> getAllBookmarks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bookmarksJson = prefs.getStringList(_bookmarksKey) ?? [];

      return bookmarksJson
          .map((json) => Bookmark.fromJson(jsonDecode(json)))
          .toList();
    } catch (e) {
      throw Exception('Failed to load bookmarks: $e');
    }
  }

  // Add bookmark
  Future<void> addBookmark(Bookmark bookmark) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bookmarks = await getAllBookmarks();

      // Check if bookmark already exists
      final exists = bookmarks.any(
        (b) =>
            b.surahNumber == bookmark.surahNumber &&
            b.ayahNumber == bookmark.ayahNumber,
      );

      if (!exists) {
        bookmarks.add(bookmark);
        final bookmarksJson = bookmarks
            .map((b) => jsonEncode(b.toJson()))
            .toList();

        await prefs.setStringList(_bookmarksKey, bookmarksJson);
      }
    } catch (e) {
      throw Exception('Failed to add bookmark: $e');
    }
  }

  // Remove bookmark
  Future<void> removeBookmark(String bookmarkId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bookmarks = await getAllBookmarks();

      bookmarks.removeWhere((b) => b.id == bookmarkId);

      final bookmarksJson = bookmarks
          .map((b) => jsonEncode(b.toJson()))
          .toList();

      await prefs.setStringList(_bookmarksKey, bookmarksJson);
    } catch (e) {
      throw Exception('Failed to remove bookmark: $e');
    }
  }

  // Update bookmark note
  Future<void> updateBookmarkNote(String bookmarkId, String note) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bookmarks = await getAllBookmarks();

      final index = bookmarks.indexWhere((b) => b.id == bookmarkId);
      if (index != -1) {
        bookmarks[index] = bookmarks[index].copyWith(note: note);

        final bookmarksJson = bookmarks
            .map((b) => jsonEncode(b.toJson()))
            .toList();

        await prefs.setStringList(_bookmarksKey, bookmarksJson);
      }
    } catch (e) {
      throw Exception('Failed to update bookmark: $e');
    }
  }

  // Check if ayah is bookmarked
  Future<bool> isBookmarked(int surahNumber, int ayahNumber) async {
    try {
      final bookmarks = await getAllBookmarks();
      return bookmarks.any(
        (b) => b.surahNumber == surahNumber && b.ayahNumber == ayahNumber,
      );
    } catch (e) {
      return false;
    }
  }

  // Get bookmark by surah and ayah
  Future<Bookmark?> getBookmark(int surahNumber, int ayahNumber) async {
    try {
      final bookmarks = await getAllBookmarks();
      return bookmarks.firstWhere(
        (b) => b.surahNumber == surahNumber && b.ayahNumber == ayahNumber,
      );
    } catch (e) {
      return null;
    }
  }
}
