class Surah {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final String revelationType;
  final int numberOfAyahs;
  final List<Ayah> ayahs;

  Surah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.revelationType,
    required this.numberOfAyahs,
    required this.ayahs,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {

    return Surah(
      number: json['number'] ?? 0,
      name: json['name'] ?? '',
      englishName: json['englishName'] ?? '',
      englishNameTranslation: json['englishNameTranslation'] ?? '',
      revelationType: json['revelationType'] ?? '',
      numberOfAyahs: json['numberOfAyahs'] ?? 0,
      ayahs:
          (json['ayahs'] as List<dynamic>?)?.map((ayah) {
            return Ayah.fromJson(ayah);
          }).toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
      'englishName': englishName,
      'englishNameTranslation': englishNameTranslation,
      'revelationType': revelationType,
      'numberOfAyahs': numberOfAyahs,
      'ayahs': ayahs.map((ayah) => ayah.toJson()).toList(),
    };
  }
}

class Ayah {
  final int number;
  final String text;
  final int numberInSurah;
  final int juz;
  final int manzil;
  final int page;
  final int ruku;
  final int hizbQuarter;
  final String sajda;
  final Translation translation;

  Ayah({
    required this.number,
    required this.text,
    required this.numberInSurah,
    required this.juz,
    required this.manzil,
    required this.page,
    required this.ruku,
    required this.hizbQuarter,
    required this.sajda,
    required this.translation,
  });

  factory Ayah.fromJson(Map<String, dynamic> json) {

    // Handle sajda field yang mungkin bool atau string
    String sajdaValue = '';
    if (json['sajda'] != null) {
      if (json['sajda'] is bool) {
        sajdaValue = json['sajda'] ? 'true' : 'false';
      } else if (json['sajda'] is String) {
        sajdaValue = json['sajda'];
      } else {
        sajdaValue = json['sajda'].toString();
      }
    }

    // Handle translation data - API might return translations in different formats
    Map<String, dynamic> translationData = {};
    
    // Check if translation is directly in the json
    if (json['translation'] != null) {
      translationData = json['translation'] is Map<String, dynamic> 
          ? json['translation'] 
          : {};
    }
    
    // Check if translations are in separate fields (for multi-edition API)
    if (json['id.indonesian'] != null || json['en.sahih'] != null) {
      translationData = {
        'id.indonesian': json['id.indonesian'],
        'en.sahih': json['en.sahih'],
      };
    }

    return Ayah(
      number: json['number'] ?? 0,
      text: json['text'] ?? '',
      numberInSurah: json['numberInSurah'] ?? 0,
      juz: json['juz'] ?? 0,
      manzil: json['manzil'] ?? 0,
      page: json['page'] ?? 0,
      ruku: json['ruku'] ?? 0,
      hizbQuarter: json['hizbQuarter'] ?? 0,
      sajda: sajdaValue,
      translation: Translation.fromJson(translationData),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'text': text,
      'numberInSurah': numberInSurah,
      'juz': juz,
      'manzil': manzil,
      'page': page,
      'ruku': ruku,
      'hizbQuarter': hizbQuarter,
      'sajda': sajda,
      'translation': translation.toJson(),
    };
  }
}

class Translation {
  final String id;
  final String en;

  Translation({required this.id, required this.en});

  factory Translation.fromJson(Map<String, dynamic> json) {
    // Handle different API response structures
    String idText = '';
    String enText = '';

    // Try different possible field names for Indonesian translation
    if (json['id'] != null) {
      idText = json['id'].toString();
    } else if (json['indonesian'] != null) {
      idText = json['indonesian'].toString();
    } else if (json['id.indonesian'] != null) {
      idText = json['id.indonesian'].toString();
    }

    // Try different possible field names for English translation
    if (json['en'] != null) {
      enText = json['en'].toString();
    } else if (json['english'] != null) {
      enText = json['english'].toString();
    } else if (json['en.sahih'] != null) {
      enText = json['en.sahih'].toString();
    }

    return Translation(id: idText, en: enText);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'en': en};
  }
}
