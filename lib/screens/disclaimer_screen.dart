import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/text_styles.dart';

class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      _DisclaimerSectionData(
        title: 'disclaimer.sections.demo.title'.tr(),
        body: 'disclaimer.sections.demo.body'.tr(),
      ),
      _DisclaimerSectionData(
        title: 'disclaimer.sections.warranty.title'.tr(),
        body: 'disclaimer.sections.warranty.body'.tr(),
      ),
      _DisclaimerSectionData(
        title: 'disclaimer.sections.api.title'.tr(),
        body: 'disclaimer.sections.api.body'.tr(),
      ),
      _DisclaimerSectionData(
        title: 'disclaimer.sections.education.title'.tr(),
        body: 'disclaimer.sections.education.body'.tr(),
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundSoft,
      body: SafeArea(
        child: Column(
          children: [
            _DisclaimerHeader(title: 'disclaimer.title'.tr()),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                children: [
                  _IntroCard(
                    eyebrow: 'disclaimer.eyebrow'.tr(),
                    title: 'disclaimer.headline'.tr(),
                    body: 'disclaimer.intro'.tr(),
                  ),
                  const SizedBox(height: 16),
                  ...sections.map(
                    (section) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _SectionCard(data: section),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primary50,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: AppColors.primary100,
                        width: 0.8,
                      ),
                    ),
                    child: Text(
                      'disclaimer.footer_note'.tr(),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primaryDark,
                        height: 1.55,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DisclaimerHeader extends StatelessWidget {
  final String title;

  const _DisclaimerHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      child: Row(
        children: [
          _CircleIconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => Navigator.pop(context),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.titleLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IntroCard extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String body;

  const _IntroCard({
    required this.eyebrow,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2E7D32), Color(0xFF1B5E20)],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.12),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            eyebrow,
            style: AppTextStyles.labelSmall.copyWith(
              color: Colors.white.withValues(alpha: 0.78),
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: AppTextStyles.headlineMedium.copyWith(
              color: Colors.white,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            body,
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final _DisclaimerSectionData data;

  const _SectionCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.borderUltraLight,
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowVeryLight,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.title,
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            data.body,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.borderUltraLight,
          width: 0.8,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(22),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 18,
          ),
        ),
      ),
    );
  }
}

class _DisclaimerSectionData {
  final String title;
  final String body;

  const _DisclaimerSectionData({
    required this.title,
    required this.body,
  });
}
