import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../models/surah_model.dart';
import '../utils/app_colors.dart';
import '../utils/text_styles.dart';

class SurahInfoCard extends StatelessWidget {
  final Surah surah;

  const SurahInfoCard({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderUltraLight, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowVeryLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Surah Name - Arabic
          Text(surah.name, style: AppTextStyles.arabicLarge),
          const SizedBox(height: 12),

          // English Name
          Text(surah.englishName, style: AppTextStyles.secondaryLarge),
          const SizedBox(height: 6),

          // English Translation
          Text(surah.englishNameTranslation, style: AppTextStyles.captionLarge),
          const SizedBox(height: 24),

          // Info Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildInfoItem('quran.verses'.tr(), '${surah.numberOfAyahs}'),
              _buildInfoItem('quran.revelation'.tr(), surah.revelationType, width: 100),
              _buildInfoItem(
                'quran.surah'.tr(args: ['${surah.number}']),
                '${surah.number}',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, {double? width}) {
    return Column(
      children: [
        // Value Container - Softer design
        Container(
          height: 48,
          width: width ?? 48,
          decoration: BoxDecoration(
            color: AppColors.primary50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.primary100, width: 0.5),
          ),
          child: Center(child: Text(value, style: AppTextStyles.numberMedium)),
        ),
        const SizedBox(height: 10),

        // Label Text
        Text(
          label,
          style: AppTextStyles.captionSmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
