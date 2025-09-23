import 'package:flutter/material.dart';

import '../models/surah_model.dart';
import '../utils/app_colors.dart';
import 'surah_card_content.dart';

class SurahCard extends StatefulWidget {
  final Surah surah;

  const SurahCard({super.key, required this.surah});

  @override
  State<SurahCard> createState() => _SurahCardState();
}

class _SurahCardState extends State<SurahCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
  }

  void _initializeAnimation() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: _navigateToSurahDetail,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceSoft,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.borderUltraLight,
                  width: 0.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowVeryLight,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SurahCardContent(surah: widget.surah),
              ),
            ),
          );
        },
      ),
    );
  }

  void _navigateToSurahDetail() {
    Navigator.pushNamed(
      context,
      '/surah-detail',
      arguments: widget.surah.number,
    );
  }
}
