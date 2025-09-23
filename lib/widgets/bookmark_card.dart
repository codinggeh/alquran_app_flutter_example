import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/bookmark_model.dart';
import '../providers/bookmark_provider.dart';
import '../utils/app_colors.dart';
import '../utils/snackbar_utils.dart';
import 'bookmark_card_content.dart';
import 'bookmark_card_header.dart';

class BookmarkCard extends StatelessWidget {
  final Bookmark bookmark;

  const BookmarkCard({super.key, required this.bookmark});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _navigateToAyah(context),
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookmarkCardHeader(
                bookmark: bookmark,
                onBookmarkTap: () => _removeBookmark(context),
              ),
              BookmarkCardContent(bookmark: bookmark),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToAyah(BuildContext context) {
    Navigator.pushNamed(
      context,
      '/surah-detail',
      arguments: {
        'surahNumber': bookmark.surahNumber,
        'scrollToAyah': bookmark.ayahNumber,
      },
    );
  }

  void _removeBookmark(BuildContext context) {
    final bookmarkProvider = context.read<BookmarkProvider>();
    bookmarkProvider.removeBookmark(bookmark.surahNumber, bookmark.ayahNumber);
    SnackbarUtils.showBookmarkRemoved(context);
  }
}
