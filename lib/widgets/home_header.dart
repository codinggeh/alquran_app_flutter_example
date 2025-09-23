import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/text_styles.dart';
import 'action_button.dart';

class HomeHeader extends StatelessWidget {
  final TextEditingController searchController;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onLanguageTap;
  final VoidCallback onBookmarkTap;

  const HomeHeader({
    super.key,
    required this.searchController,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.onLanguageTap,
    required this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      child: Row(
        children: [
          _buildSearchBar(),
          const SizedBox(width: 12),
          _buildLanguageButton(context),
          const SizedBox(width: 8),
          _buildBookmarkButton(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Expanded(
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.surfaceSoft,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.borderUltraLight, width: 0.5),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowVeryLight,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: searchController,
          onChanged: onSearchChanged,
          decoration: InputDecoration(
            hintText: 'quran.search_hint'.tr(),
            hintStyle: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textTertiary,
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: AppColors.textSecondary,
              size: 20,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
          ),
          style: AppTextStyles.bodyMedium,
        ),
      ),
    );
  }

  Widget _buildLanguageButton(BuildContext context) {
    final currentLocale = context.locale;
    final isIndonesian = currentLocale.languageCode == 'id';

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderUltraLight, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowVeryLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onLanguageTap,
          borderRadius: BorderRadius.circular(24),
          child: Center(
            child: Text(
              isIndonesian ? 'ID' : 'EN',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBookmarkButton() {
    return ActionButton(
      icon: Icons.bookmark_outline_rounded,
      onTap: onBookmarkTap,
      size: 48,
    );
  }
}
