import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../models/bookmark_model.dart';
import '../utils/app_colors.dart';
import '../utils/text_styles.dart';

class BookmarkCardContent extends StatelessWidget {
  final Bookmark bookmark;

  const BookmarkCardContent({super.key, required this.bookmark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildArabicText(),
          const SizedBox(height: 16),
          _buildTranslationText(),
          const SizedBox(height: 16),
          _buildDateInfo(context),
        ],
      ),
    );
  }

  Widget _buildArabicText() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary100, width: 0.5),
      ),
      child: Text(
        bookmark.ayahText,
        style: AppTextStyles.arabicSmall,
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _buildTranslationText() {
    return Text(
      bookmark.translation,
      style: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.textSecondary,
        height: 1.5,
      ),
    );
  }

  Widget _buildDateInfo(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.access_time_rounded,
          size: 16,
          color: AppColors.textTertiary,
        ),
        const SizedBox(width: 8),
        Text(
          _formatDate(context, bookmark.createdAt),
          style: AppTextStyles.captionMedium.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
      ],
    );
  }

  String _formatDate(BuildContext context, DateTime date) {
    final currentLocale = context.locale;
    final isIndonesian = currentLocale.languageCode == 'id';
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return '${'date.today'.tr()} ${_formatTime(date)}';
    } else if (difference.inDays == 1) {
      return '${'date.yesterday'.tr()} ${_formatTime(date)}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ${'date.days_ago'.tr()}';
    } else {
      return isIndonesian
          ? '${date.day}/${date.month}/${date.year}'
          : '${date.month}/${date.day}/${date.year}';
    }
  }

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
