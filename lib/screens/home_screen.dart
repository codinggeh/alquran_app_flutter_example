import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quran_provider.dart';
import '../utils/app_colors.dart';
import '../widgets/error_widget.dart';
import '../widgets/home_header.dart';
import '../widgets/loading_widget.dart';
import '../widgets/search_empty_state.dart';
import '../widgets/surah_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadData();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );
  }

  void _loadData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuranProvider>().loadSurahs();
      _fadeController.forward();
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSoft,
      body: SafeArea(
        child: Column(children: [_buildHeader(), _buildContent()]),
      ),
    );
  }

  Widget _buildHeader() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: HomeHeader(
          searchController: _searchController,
          searchQuery: _searchQuery,
          onSearchChanged: _onSearchChanged,
          onLanguageTap: _switchLanguage,
          onBookmarkTap: _navigateToBookmarks,
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: Consumer<QuranProvider>(
        builder: (context, quranProvider, child) {
          if (quranProvider.isLoading) {
            return const LoadingWidget();
          }

          if (quranProvider.error != null) {
            return CustomErrorWidget(
              message: quranProvider.error!,
              onRetry: () => quranProvider.loadSurahs(),
            );
          }

          final surahs = quranProvider.surahs;
          if (surahs.isEmpty) {
            return CustomErrorWidget(message: 'quran.surah_not_found'.tr());
          }

          final filteredSurahs = _filterSurahs(surahs, _searchQuery);

          if (_searchQuery.isNotEmpty && filteredSurahs.isEmpty) {
            return const SearchEmptyState();
          }

          return RefreshIndicator(
            onRefresh: () async {
              await quranProvider.loadSurahs();
            },
            color: AppColors.primary,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: filteredSurahs.length,
              itemBuilder: (context, index) {
                final surah = filteredSurahs[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: SurahCard(surah: surah),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _switchLanguage() {
    final currentLocale = context.locale;
    final newLocale = currentLocale.languageCode == 'id'
        ? const Locale('en', 'US')
        : const Locale('id', 'ID');

    context.setLocale(newLocale);
  }

  void _navigateToBookmarks() {
    Navigator.pushNamed(context, '/bookmarks');
  }

  List<dynamic> _filterSurahs(List<dynamic> surahs, String query) {
    if (query.isEmpty) {
      return surahs;
    }

    final lowercaseQuery = query.toLowerCase();
    return surahs.where((surah) {
      return surah.name.toLowerCase().contains(lowercaseQuery) ||
          surah.englishName.toLowerCase().contains(lowercaseQuery) ||
          surah.englishNameTranslation.toLowerCase().contains(lowercaseQuery) ||
          surah.number.toString().contains(lowercaseQuery);
    }).toList();
  }
}
