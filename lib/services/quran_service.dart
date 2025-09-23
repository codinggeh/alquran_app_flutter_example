import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/surah_model.dart';

class QuranService {
  static const String _baseUrl = 'https://api.alquran.cloud/v1';

  // Get all surahs
  Future<List<Surah>> getAllSurahs() async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/surah'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> surahsData = data['data'];

        return surahsData.map((json) {
          return Surah.fromJson(json);
        }).toList();
      } else {
        throw Exception('Failed to load surahs: ${response.statusCode}');
      }
    } catch (e) {
      if (e.toString().contains('SocketException') ||
          e.toString().contains('TimeoutException')) {
        throw Exception('Network error: Tidak ada koneksi internet');
      }
      throw Exception('Error loading surahs: $e');
    }
  }

  // Get specific surah with ayahs
  Future<Surah> getSurah(int surahNumber) async {
    try {
      // Use separate API calls for better translation support
      final response = await http
          .get(Uri.parse('$_baseUrl/surah/$surahNumber'))
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final surahData = data['data'];

        // Handle both List and Map response formats
        if (surahData is List && surahData.isNotEmpty) {
          // API returns array, take first item
          return Surah.fromJson(surahData[0]);
        } else if (surahData is Map<String, dynamic>) {
          // API returns single object
          return Surah.fromJson(surahData);
        } else {
          throw Exception('Invalid data format from API');
        }
      } else {
        throw Exception('Failed to load surah: ${response.statusCode}');
      }
    } catch (e) {
      if (e.toString().contains('SocketException') ||
          e.toString().contains('TimeoutException')) {
        throw Exception('Network error: Tidak ada koneksi internet');
      }
      throw Exception('Error loading surah: $e');
    }
  }

  // Get specific ayah
  Future<Ayah> getAyah(int surahNumber, int ayahNumber) async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/surah/$surahNumber/$ayahNumber'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Ayah.fromJson(data['data']);
      } else {
        throw Exception('Failed to load ayah: ${response.statusCode}');
      }
    } catch (e) {
      if (e.toString().contains('SocketException') ||
          e.toString().contains('TimeoutException')) {
        throw Exception('Network error: Tidak ada koneksi internet');
      }
      throw Exception('Error loading ayah: $e');
    }
  }

  // Get translations for a surah
  Future<Map<String, String>> getTranslations(int surahNumber) async {
    try {
      final Map<String, String> translations = {};

      // Get Indonesian translation
      try {
        final idResponse = await http
            .get(Uri.parse('$_baseUrl/surah/$surahNumber/id.indonesian'))
            .timeout(const Duration(seconds: 10));

        if (idResponse.statusCode == 200) {
          final idData = json.decode(idResponse.body);
          if (idData['data'] != null && idData['data']['ayahs'] != null) {
            final ayahs = idData['data']['ayahs'] as List;
            for (var ayah in ayahs) {
              final ayahNumber = ayah['numberInSurah'];
              final text = ayah['text'] ?? '';
              translations['id_$ayahNumber'] = text;
            }
          }
        }
      } catch (e) {
        // Indonesian translation failed, continue with English
      }

      // Get English translation
      try {
        final enResponse = await http
            .get(Uri.parse('$_baseUrl/surah/$surahNumber/en.sahih'))
            .timeout(const Duration(seconds: 10));

        if (enResponse.statusCode == 200) {
          final enData = json.decode(enResponse.body);
          if (enData['data'] != null && enData['data']['ayahs'] != null) {
            final ayahs = enData['data']['ayahs'] as List;
            for (var ayah in ayahs) {
              final ayahNumber = ayah['numberInSurah'];
              final text = ayah['text'] ?? '';
              translations['en_$ayahNumber'] = text;
            }
          }
        }
      } catch (e) {
        // English translation failed
      }

      return translations;
    } catch (e) {
      return {};
    }
  }

  // Search surahs by name
  Future<List<Surah>> searchSurahs(String query) async {
    try {
      final allSurahs = await getAllSurahs();
      return allSurahs.where((surah) {
        final name = surah.name.toLowerCase();
        final englishName = surah.englishName.toLowerCase();
        final englishTranslation = surah.englishNameTranslation.toLowerCase();
        final searchQuery = query.toLowerCase();

        return name.contains(searchQuery) ||
            englishName.contains(searchQuery) ||
            englishTranslation.contains(searchQuery);
      }).toList();
    } catch (e) {
      throw Exception('Search error: $e');
    }
  }
}
