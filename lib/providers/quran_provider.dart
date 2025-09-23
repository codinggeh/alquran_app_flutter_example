import 'package:flutter/foundation.dart';

import '../models/surah_model.dart';
import '../services/quran_service.dart';

class QuranProvider with ChangeNotifier {
  final QuranService _quranService = QuranService();

  List<Surah> _surahs = [];
  Surah? _currentSurah;
  bool _isLoading = false;
  String? _error;
  List<Surah> _searchResults = [];
  bool _isSearching = false;
  bool _disposed = false;

  // Getters
  List<Surah> get surahs => _surahs;
  Surah? get currentSurah => _currentSurah;
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Surah> get searchResults => _searchResults;
  bool get isSearching => _isSearching;

  // Load all surahs
  Future<void> loadSurahs() async {
    try {
      _isLoading = true;
      _error = null;
      if (!_disposed) notifyListeners();

      _surahs = await _quranService.getAllSurahs();
      _isLoading = false;
      if (!_disposed) notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      if (!_disposed) notifyListeners();
    }
  }

  // Load specific surah
  Future<void> loadSurah(int surahNumber) async {
    try {
      _isLoading = true;
      _error = null;
      // Clear current surah data to prevent showing old data
      _currentSurah = null;
      if (!_disposed) notifyListeners();

      _currentSurah = await _quranService.getSurah(surahNumber);

      // Load translations separately
      final translations = await _quranService.getTranslations(surahNumber);

      // Update ayahs with translations
      if (_currentSurah != null) {
        final updatedAyahs = _currentSurah!.ayahs.map((ayah) {
          final ayahNumber = ayah.numberInSurah;
          final idTranslation = translations['id_$ayahNumber'] ?? '';
          final enTranslation = translations['en_$ayahNumber'] ?? '';

          return Ayah(
            number: ayah.number,
            text: ayah.text,
            numberInSurah: ayah.numberInSurah,
            juz: ayah.juz,
            manzil: ayah.manzil,
            page: ayah.page,
            ruku: ayah.ruku,
            hizbQuarter: ayah.hizbQuarter,
            sajda: ayah.sajda,
            translation: Translation(id: idTranslation, en: enTranslation),
          );
        }).toList();

        _currentSurah = Surah(
          number: _currentSurah!.number,
          name: _currentSurah!.name,
          englishName: _currentSurah!.englishName,
          englishNameTranslation: _currentSurah!.englishNameTranslation,
          revelationType: _currentSurah!.revelationType,
          numberOfAyahs: _currentSurah!.numberOfAyahs,
          ayahs: updatedAyahs,
        );
      }

      _isLoading = false;
      if (!_disposed) notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      if (!_disposed) notifyListeners();
    }
  }

  // Clear current surah data
  void clearCurrentSurah() {
    _currentSurah = null;
    _error = null;
    // Use microtask to avoid calling notifyListeners during widget disposal
    Future.microtask(() {
      if (!_disposed) {
        notifyListeners();
      }
    });
  }

  // Search surahs
  Future<void> searchSurahs(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      _isSearching = false;
      if (!_disposed) notifyListeners();
      return;
    }

    try {
      _isSearching = true;
      if (!_disposed) notifyListeners();

      _searchResults = await _quranService.searchSurahs(query);
      _isSearching = false;
      if (!_disposed) notifyListeners();
    } catch (e) {
      _isSearching = false;
      _error = e.toString();
      if (!_disposed) notifyListeners();
    }
  }

  // Clear search
  void clearSearch() {
    _searchResults = [];
    _isSearching = false;
    if (!_disposed) notifyListeners();
  }

  // Clear error
  void clearError() {
    _error = null;
    if (!_disposed) notifyListeners();
  }

  // Get surah by number
  Surah? getSurahByNumber(int number) {
    try {
      return _surahs.firstWhere((surah) => surah.number == number);
    } catch (e) {
      return null;
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
