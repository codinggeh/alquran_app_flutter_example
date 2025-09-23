import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quran_provider.dart';
import '../utils/app_colors.dart';
import '../widgets/surah_detail_content.dart';
import '../widgets/surah_detail_header.dart';

class SurahDetailScreen extends StatefulWidget {
  final int surahNumber;
  final int? scrollToAyah;

  const SurahDetailScreen({
    super.key,
    required this.surahNumber,
    this.scrollToAyah,
  });

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  final ScrollController _scrollController = ScrollController();
  QuranProvider? _quranProvider;

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
      _loadSurahData();
      _fadeController.forward();
      _slideController.forward();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _quranProvider = context.read<QuranProvider>();
  }

  @override
  void didUpdateWidget(SurahDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.surahNumber != widget.surahNumber) {
      _loadSurahData();
    }
  }

  Future<void> _loadSurahData() async {
    final quranProvider = _quranProvider ?? context.read<QuranProvider>();
    await quranProvider.loadSurah(widget.surahNumber);
    if (widget.scrollToAyah != null) {
      _scrollToAyah(widget.scrollToAyah!);
    }
  }

  void _scrollToAyah(int ayahNumber) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        final estimatedPosition = (ayahNumber - 1) * 200.0;
        _scrollController.animateTo(
          estimatedPosition,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scrollController.dispose();
    _quranProvider?.clearCurrentSurah();
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
        child: SurahDetailHeader(
          surahNumber: widget.surahNumber,
          onAudioTap: _handleAudioTap,
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: SurahDetailContent(
        scrollController: _scrollController,
        onRefresh: _loadSurahData,
      ),
    );
  }

  void _handleAudioTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('quran.audio_player'.tr()),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
