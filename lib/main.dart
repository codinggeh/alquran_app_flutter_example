import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/audio_provider.dart';
import 'providers/bookmark_provider.dart';
import 'providers/quran_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/bookmarks_screen.dart';
import 'screens/home_screen.dart';
import 'screens/surah_detail_screen.dart';
import 'utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('id', 'ID'), Locale('en', 'US')],
      path: 'assets/i18n',
      fallbackLocale: const Locale('id', 'ID'),
      useOnlyLangCode: false,
      saveLocale: true,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuranProvider()),
        ChangeNotifierProvider(create: (_) => BookmarkProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AudioProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: AppConstants.appName,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: themeProvider.currentTheme,
            themeMode: ThemeMode.light,
            initialRoute: '/',
            routes: {
              '/': (context) => const HomeScreen(),
              '/surah-detail': (context) {
                final surahNumber =
                    ModalRoute.of(context)!.settings.arguments as int;
                return SurahDetailScreen(surahNumber: surahNumber);
              },
              '/bookmarks': (context) => const BookmarksScreen(),
            },
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}