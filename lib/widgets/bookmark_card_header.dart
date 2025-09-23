import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../models/bookmark_model.dart';
import '../utils/app_colors.dart';
import '../utils/text_styles.dart';
import 'action_button.dart';

class BookmarkCardHeader extends StatelessWidget {
  final Bookmark bookmark;
  final VoidCallback onBookmarkTap;

  const BookmarkCardHeader({
    super.key,
    required this.bookmark,
    required this.onBookmarkTap,
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
          _buildBookmarkButton(),
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
        child: Text('${bookmark.ayahNumber}', style: AppTextStyles.numberLarge),
      ),
    );
  }

  Widget _buildSurahInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(bookmark.surahName, style: AppTextStyles.titleMedium),
          Text(
            '${'quran.verses'.tr()} ${bookmark.ayahNumber}',
            style: AppTextStyles.secondaryMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildBookmarkButton() {
    return ActionButton(
      icon: Icons.bookmark_rounded,
      onTap: onBookmarkTap,
      iconColor: AppColors.primary,
    );
  }
}
