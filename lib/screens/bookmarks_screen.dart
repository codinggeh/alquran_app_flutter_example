import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/bookmark_provider.dart';
import '../utils/app_colors.dart';
import '../utils/snackbar_utils.dart';
import '../widgets/bookmark_card.dart';
import '../widgets/bookmarks_empty_state.dart';
import '../widgets/bookmarks_header.dart';
import '../widgets/clear_all_dialog.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fadeController.forward();
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSoft,
      body: SafeArea(
        child: Column(
          children: [
            // Header with consistent design
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: BookmarksHeader(
                  onClearAll: () => _showClearAllDialog(context),
                ),
              ),
            ),

            // Content with proper spacing
            Expanded(
              child: Consumer<BookmarkProvider>(
                builder: (context, bookmarkProvider, child) {
                  final bookmarks = bookmarkProvider.bookmarks.values.toList();

                  // Sort by creation date (newest first)
                  bookmarks.sort((a, b) => b.createdAt.compareTo(a.createdAt));

                  if (bookmarks.isEmpty) {
                    return const BookmarksEmptyState();
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: bookmarks.length,
                    itemBuilder: (context, index) {
                      final bookmark = bookmarks[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: BookmarkCard(bookmark: bookmark),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showClearAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ClearAllDialog(
        onConfirm: () {
          context.read<BookmarkProvider>().clearAllBookmarks();
          SnackbarUtils.showAllBookmarksCleared(context);
        },
      ),
    );
  }
}
