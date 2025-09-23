import 'dart:convert';

import 'package:http/http.dart' as http;

class AudioService {
  static const String _baseUrl = 'https://api.alquran.cloud/v1';

  /// Get audio URL for a specific ayah
  static Future<String?> getAyahAudioUrl(int ayahNumber) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/ayah/$ayahNumber/ar.alafasy'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final audioUrl = data['data']['audio'];
        return audioUrl;
      }
    } catch (e) {
      // Error handling
    }
    return null;
  }

  /// Get audio URL for a specific surah
  static Future<String?> getSurahAudioUrl(int surahNumber) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/surah/$surahNumber/ar.alafasy'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final audioUrl = data['data']['audio'];
        return audioUrl;
      }
    } catch (e) {
      // Error handling
    }
    return null;
  }
}
