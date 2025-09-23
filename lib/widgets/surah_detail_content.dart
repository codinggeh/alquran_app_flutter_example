import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quran_provider.dart';
import '../utils/app_colors.dart';
import 'ayah_card.dart';
import 'error_widget.dart';
import 'loading_widget.dart';

class SurahDetailContent extends StatelessWidget {
  final ScrollController scrollController;
  final Future<void> Function() onRefresh;

  const SurahDetailContent({
    super.key,
    required this.scrollController,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<QuranProvider>(
      builder: (context, quranProvider, child) {
        if (quranProvider.isLoading) {
          return const LoadingWidget();
        }

        if (quranProvider.error != null) {
          return CustomErrorWidget(
            message: quranProvider.error!,
            onRetry: () => onRefresh(),
          );
        }

        final surah = quranProvider.currentSurah;
        if (surah == null) {
          return CustomErrorWidget(message: 'quran.surah_not_found'.tr());
        }

        return RefreshIndicator(
          onRefresh: onRefresh,
          color: AppColors.primary,
          child: ListView.builder(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: surah.ayahs.length,
            itemBuilder: (context, index) {
              final ayah = surah.ayahs[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AyahCard(ayah: ayah, surahName: surah.name),
              );
            },
          ),
        );
      },
    );
  }
}
