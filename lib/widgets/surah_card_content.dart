import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../models/surah_model.dart';
import '../utils/app_colors.dart';
import '../utils/text_styles.dart';

class SurahCardContent extends StatelessWidget {
  final Surah surah;

  const SurahCardContent({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildSurahNumber(),
        const SizedBox(width: 16),
        Expanded(child: _buildSurahInfo(context)),
        const SizedBox(width: 12),
        _buildAyahCount(context),
      ],
    );
  }

  Widget _buildSurahNumber() {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.primary50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary100, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowVeryLight,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Center(
        child: Text('${surah.number}', style: AppTextStyles.numberMedium),
      ),
    );
  }

  Widget _buildSurahInfo(BuildContext context) {
    final currentLocale = context.locale;
    final isIndonesian = currentLocale.languageCode == 'id';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          surah.name,
          style: AppTextStyles.arabicSmall,
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 4),
        Text(
          isIndonesian ? surah.englishName : surah.englishName,
          style: AppTextStyles.titleMedium,
        ),
        const SizedBox(height: 2),
        Text(
          isIndonesian
              ? 'Surah ${surah.englishName}'
              : surah.englishNameTranslation,
          style: AppTextStyles.captionMedium,
        ),
      ],
    );
  }

  Widget _buildAyahCount(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary100, width: 0.5),
      ),
      child: Text(
        '${surah.numberOfAyahs} ${'quran.verses'.tr()}',
        style: AppTextStyles.captionSmall,
      ),
    );
  }
}
