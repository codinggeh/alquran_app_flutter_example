import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/surah_model.dart';
import '../providers/audio_provider.dart';
import '../providers/bookmark_provider.dart';
import '../utils/app_colors.dart';
import '../utils/snackbar_utils.dart';
import 'ayah_content.dart';
import 'ayah_header.dart';

class AyahCard extends StatefulWidget {
  final Ayah ayah;
  final String surahName;

  const AyahCard({super.key, required this.ayah, required this.surahName});

  @override
  State<AyahCard> createState() => _AyahCardState();
}

class _AyahCardState extends State<AyahCard> {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AyahHeader(
            ayah: widget.ayah,
            surahName: widget.surahName,
            onBookmarkTap: _handleBookmarkTap,
            onAudioTap: _handleAudioTap,
          ),
          AyahContent(ayah: widget.ayah),
        ],
      ),
    );
  }

  void _handleBookmarkTap() {
    final bookmarkProvider = context.read<BookmarkProvider>();
    final isBookmarked = bookmarkProvider.isBookmarked(
      widget.ayah.number,
      widget.ayah.numberInSurah,
    );

    if (isBookmarked) {
      bookmarkProvider.removeBookmark(
        widget.ayah.number,
        widget.ayah.numberInSurah,
      );
      SnackbarUtils.showBookmarkRemoved(context);
    } else {
      bookmarkProvider.addBookmark(
        widget.ayah.number,
        widget.ayah.numberInSurah,
        widget.surahName,
        widget.ayah.text,
        _getTranslationText(),
      );
      SnackbarUtils.showBookmarkAdded(context);
    }
  }

  void _handleAudioTap() {
    final audioProvider = context.read<AudioProvider>();

    if (audioProvider.currentAyahNumber == widget.ayah.numberInSurah &&
        audioProvider.currentSurahNumber == widget.ayah.numberInSurah) {
      if (audioProvider.isPlaying) {
        audioProvider.pauseAudio();
      } else {
        audioProvider.playAyahAudio(
          widget.ayah.number,
          surahNumber: widget.ayah.numberInSurah,
          ayahNumberInSurah: widget.ayah.numberInSurah,
        );
      }
    } else {
      audioProvider.playAyahAudio(
        widget.ayah.number,
        surahNumber: widget.ayah.numberInSurah,
        ayahNumberInSurah: widget.ayah.numberInSurah,
      );
    }
  }

  String _getTranslationText() {
    final currentLocale = context.locale;
    final isIndonesian = currentLocale.languageCode == 'id';

    if (isIndonesian) {
      return widget.ayah.translation.id.isNotEmpty
          ? widget.ayah.translation.id
          : 'quran.translation_not_available'.tr();
    } else {
      return widget.ayah.translation.en.isNotEmpty
          ? widget.ayah.translation.en
          : 'quran.translation_not_available'.tr();
    }
  }
}
