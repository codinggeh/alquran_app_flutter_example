import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../models/surah_model.dart';
import '../utils/app_colors.dart';
import '../utils/text_styles.dart';

class AyahContent extends StatelessWidget {
  final Ayah ayah;
  final Locale? locale;

  const AyahContent({super.key, required this.ayah, this.locale});

  @override
  Widget build(BuildContext context) {
    final currentLocale = locale ?? context.locale;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildArabicText(), _buildTranslationSection(currentLocale)],
    );
  }

  Widget _buildArabicText() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Text(
        ayah.text,
        style: AppTextStyles.arabicMedium,
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _buildTranslationSection(Locale currentLocale) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderUltraLight, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'quran.translation'.tr(),
            style: AppTextStyles.captionMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _getTranslationText(currentLocale),
            style: AppTextStyles.bodyLarge,
          ),
        ],
      ),
    );
  }

  String _getTranslationText(Locale currentLocale) {
    final isIndonesian = currentLocale.languageCode == 'id';

    if (isIndonesian) {
      return ayah.translation.id.isNotEmpty
          ? ayah.translation.id
          : 'quran.translation_not_available'.tr();
    } else {
      return ayah.translation.en.isNotEmpty
          ? ayah.translation.en
          : 'quran.translation_not_available'.tr();
    }
  }
}
