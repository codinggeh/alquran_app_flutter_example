class AppConstants {
  // App Info
  static const String appName = 'Al-Quran App';
  static const String appVersion = '1.0.0';

  // API
  static const String baseUrl = 'https://api.alquran.cloud/v1';
  static const String surahEndpoint = '/surah';
  static const String ayahEndpoint = '/ayah';

  // Storage Keys
  static const String bookmarksKey = 'bookmarks';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language';

  // Audio
  static const List<String> reciters = [
    'mishary_rashid_alafasy',
    'abdul_rahman_al_sudais',
    'saad_al_ghamdi',
    'ahmed_al_ajmi',
    'muhammad_siddiq_al_minshawi',
  ];

  // Colors
  static const int primaryGreen = 0xFF2E7D32;
  static const int secondaryGreen = 0xFF4CAF50;
  static const int lightGreen = 0xFF81C784;
  static const int darkGreen = 0xFF1B5E20;

  // Dimensions
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;
  static const double cardElevation = 2.0;

  // Animation
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration fastAnimationDuration = Duration(milliseconds: 150);
  static const Duration slowAnimationDuration = Duration(milliseconds: 500);

  // Text Sizes
  static const double smallTextSize = 12.0;
  static const double mediumTextSize = 14.0;
  static const double largeTextSize = 16.0;
  static const double extraLargeTextSize = 18.0;
  static const double titleTextSize = 20.0;
  static const double headingTextSize = 24.0;

  // Arabic Text Sizes
  static const double arabicSmallTextSize = 16.0;
  static const double arabicMediumTextSize = 18.0;
  static const double arabicLargeTextSize = 20.0;
  static const double arabicExtraLargeTextSize = 22.0;
  static const double arabicTitleTextSize = 24.0;
  static const double arabicHeadingTextSize = 28.0;
}
