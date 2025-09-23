class Bookmark {
  final String id;
  final int surahNumber;
  final String surahName;
  final int ayahNumber;
  final String ayahText;
  final String translation;
  final String? note;
  final DateTime createdAt;

  Bookmark({
    required this.id,
    required this.surahNumber,
    required this.surahName,
    required this.ayahNumber,
    required this.ayahText,
    required this.translation,
    this.note,
    required this.createdAt,
  });

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      id: json['id'] ?? '',
      surahNumber: json['surahNumber'] ?? 0,
      surahName: json['surahName'] ?? '',
      ayahNumber: json['ayahNumber'] ?? 0,
      ayahText: json['ayahText'] ?? '',
      translation: json['translation'] ?? '',
      note: json['note'],
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'surahNumber': surahNumber,
      'surahName': surahName,
      'ayahNumber': ayahNumber,
      'ayahText': ayahText,
      'translation': translation,
      'note': note,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  Bookmark copyWith({
    String? id,
    int? surahNumber,
    String? surahName,
    int? ayahNumber,
    String? ayahText,
    String? translation,
    String? note,
    DateTime? createdAt,
  }) {
    return Bookmark(
      id: id ?? this.id,
      surahNumber: surahNumber ?? this.surahNumber,
      surahName: surahName ?? this.surahName,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      ayahText: ayahText ?? this.ayahText,
      translation: translation ?? this.translation,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
