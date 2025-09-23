import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../providers/audio_provider.dart';
import '../providers/quran_provider.dart';
import '../utils/app_colors.dart';
import '../widgets/surah_info_card.dart';

class SurahDetailHeader extends StatelessWidget {
  final int surahNumber;
  final VoidCallback? onAudioTap;

  const SurahDetailHeader({
    super.key,
    required this.surahNumber,
    this.onAudioTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<QuranProvider>(
      builder: (context, quranProvider, child) {
        final surah = quranProvider.currentSurah;

        if (surah == null) {
          return const SizedBox.shrink();
        }

        return Stack(
          children: [
            // Surah Info Card as background
            SurahInfoCard(surah: surah),

            // Back Button - Overlay top left
            Positioned(top: 20, left: 20, child: _buildBackButton(context)),

            // Audio Button - Temporarily removed
            // Positioned(top: 20, right: 20, child: _buildAudioButton(context)),
          ],
        );
      },
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

  // Widget _buildAudioButton(BuildContext context) {
  //   return Consumer<AudioProvider>(
  //     builder: (context, audioProvider, child) {
  //       // Check if this specific surah is currently playing
  //       final isCurrentSurahPlaying =
  //           audioProvider.currentSurahNumber == surahNumber &&
  //           audioProvider.isPlaying;

  //       return Container(
  //         width: 48,
  //         height: 48,
  //         decoration: BoxDecoration(
  //           color: AppColors.surfaceSoft,
  //           borderRadius: BorderRadius.circular(24),
  //           border: Border.all(color: AppColors.borderUltraLight, width: 0.5),
  //           boxShadow: [
  //             BoxShadow(
  //               color: AppColors.shadowVeryLight,
  //               blurRadius: 8,
  //               offset: const Offset(0, 2),
  //             ),
  //           ],
  //         ),
  //         child: Material(
  //           color: Colors.transparent,
  //           child: InkWell(
  //             onTap: () => _handleAudioTap(audioProvider),
  //             borderRadius: BorderRadius.circular(24),
  //             child: Icon(
  //               isCurrentSurahPlaying
  //                   ? Icons.pause_rounded
  //                   : Icons.play_arrow_rounded,
  //               color: AppColors.primary,
  //               size: 22,
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // void _handleAudioTap(AudioProvider audioProvider) {
  //   if (audioProvider.currentSurahNumber == surahNumber) {
  //     if (audioProvider.isPlaying) {
  //       audioProvider.pauseAudio();
  //     } else {
  //       audioProvider.playSurahAudio(surahNumber);
  //     }
  //   } else {
  //     audioProvider.playSurahAudio(surahNumber);
  //   }
  // }
}
