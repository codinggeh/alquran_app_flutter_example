import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/bookmark_provider.dart';
import '../utils/app_colors.dart';
import '../utils/text_styles.dart';

class BookmarksHeader extends StatelessWidget {
  final VoidCallback? onClearAll;

  const BookmarksHeader({super.key, this.onClearAll});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      child: Row(
        children: [
          // Back Button
          _buildBackButton(context),
          const SizedBox(width: 16),

          // Title
          Expanded(
            child: Text(
              'quran.bookmarks_title'.tr(),
              style: AppTextStyles.headlineMedium,
            ),
          ),

          // Clear All Button
          Consumer<BookmarkProvider>(
            builder: (context, bookmarkProvider, child) {
              if (bookmarkProvider.bookmarks.isEmpty) {
                return const SizedBox.shrink();
              }

              return _buildClearAllButton(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
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
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(24),
          child: Icon(
            Icons.chevron_left_rounded,
            color: AppColors.textPrimary,
            size: 24,
          ),
        ),
      ),
    );
  }

  Widget _buildClearAllButton(BuildContext context) {
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
          onTap: onClearAll,
          borderRadius: BorderRadius.circular(24),
          child: Icon(
            Icons.delete_outline_rounded,
            color: AppColors.error,
            size: 22,
          ),
        ),
      ),
    );
  }
}
