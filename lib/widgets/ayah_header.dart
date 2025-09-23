import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/surah_model.dart';
import '../providers/audio_provider.dart';
import '../providers/bookmark_provider.dart';
import '../utils/app_colors.dart';
import '../utils/text_styles.dart';
import 'action_button.dart';

class AyahHeader extends StatelessWidget {
  final Ayah ayah;
  final String surahName;
  final VoidCallback onBookmarkTap;
  final VoidCallback onAudioTap;

  const AyahHeader({
    super.key,
    required this.ayah,
    required this.surahName,
    required this.onBookmarkTap,
    required this.onAudioTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary50,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        border: Border.all(color: AppColors.primary100, width: 0.5),
      ),
      child: Row(
        children: [
          _buildAyahNumber(),
          const SizedBox(width: 16),
          _buildSurahInfo(),
          const Spacer(),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildAyahNumber() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryWithOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Center(
        child: Text('${ayah.numberInSurah}', style: AppTextStyles.numberLarge),
      ),
    );
  }

  Widget _buildSurahInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(surahName, style: AppTextStyles.titleMedium),
          Text(
            '${'quran.verses'.tr()} ${ayah.numberInSurah}',
            style: AppTextStyles.secondaryMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Consumer<BookmarkProvider>(
          builder: (context, bookmarkProvider, child) {
            final isBookmarked = bookmarkProvider.isBookmarked(
              ayah.number,
              ayah.numberInSurah,
            );

            return ActionButton(
              icon: isBookmarked
                  ? Icons.bookmark_rounded
                  : Icons.bookmark_outline_rounded,
              onTap: onBookmarkTap,
              iconColor: isBookmarked
                  ? AppColors.primary
                  : AppColors.textSecondary,
            );
          },
        ),
        const SizedBox(width: 8),
        Consumer<AudioProvider>(
          builder: (context, audioProvider, child) {
            final isCurrentAyahPlaying =
                audioProvider.currentAyahNumber == ayah.numberInSurah &&
                audioProvider.currentSurahNumber == ayah.numberInSurah &&
                audioProvider.isPlaying;

            return ActionButton(
              icon: isCurrentAyahPlaying
                  ? Icons.pause_rounded
                  : Icons.play_arrow_rounded,
              onTap: onAudioTap,
            );
          },
        ),
      ],
    );
  }
}
