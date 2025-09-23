import 'package:flutter/material.dart';

class AppColors {
  // Primary Green Shades
  static const Color primary = Color(0xFF2E7D32);
  static const Color primaryLight = Color(0xFF4CAF50);
  static const Color primaryDark = Color(0xFF1B5E20);
  static const Color primary50 = Color(0xFFE8F5E8);
  static const Color primary100 = Color(0xFFC8E6C9);
  static const Color primary200 = Color(0xFFA5D6A7);
  static const Color primary300 = Color(0xFF81C784);
  static const Color primary400 = Color(0xFF66BB6A);
  static const Color primary500 = Color(0xFF4CAF50);
  static const Color primary600 = Color(0xFF43A047);
  static const Color primary700 = Color(0xFF388E3C);
  static const Color primary800 = Color(0xFF2E7D32);
  static const Color primary900 = Color(0xFF1B5E20);

  // Neutral Shades
  static const Color neutral = Color(0xFF1D1D1F);
  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFEEEEEE);
  static const Color neutral300 = Color(0xFFE0E0E0);
  static const Color neutral400 = Color(0xFFBDBDBD);
  static const Color neutral500 = Color(0xFF9E9E9E);
  static const Color neutral600 = Color(0xFF757575);
  static const Color neutral700 = Color(0xFF616161);
  static const Color neutral800 = Color(0xFF424242);
  static const Color neutral900 = Color(0xFF212121);

  // Background Shades - Softer variants
  static const Color background = Color(0xFFF8F9FA);
  static const Color backgroundSoft = Color(0xFFF5F7FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSoft = Color(0xFFFEFEFE);
  static const Color surfaceVariant = Color(0xFFF8F9FA);
  static const Color surfaceVariantSoft = Color(0xFFF5F7FA);
  static const Color surfaceDark = Color(0xFF1A1A1A);

  // Text Shades
  static const Color textPrimary = Color(0xFF1D1D1F);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textTertiary = Color(0xFF9E9E9E);
  static const Color textInverse = Color(0xFFFFFFFF);

  // Border Shades - Softer variants
  static const Color borderLight = Color(0xFFE0E0E0);
  static const Color borderVeryLight = Color(0xFFF0F0F0);
  static const Color borderUltraLight = Color(0xFFF5F5F5);
  static const Color borderMedium = Color(0xFFBDBDBD);
  static const Color borderDark = Color(0xFF757575);

  // Shadow Shades - Softer variants
  static const Color shadowLight = Color(0x08000000);
  static const Color shadowVeryLight = Color(0x04000000);
  static const Color shadowMedium = Color(0x14000000);
  static const Color shadowDark = Color(0x1F000000);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Error Shades
  static const Color error50 = Color(0xFFFFEBEE);
  static const Color error100 = Color(0xFFFFCDD2);
  static const Color error200 = Color(0xFFEF9A9A);
  static const Color error300 = Color(0xFFE57373);
  static const Color error400 = Color(0xFFEF5350);
  static const Color error500 = Color(0xFFF44336);
  static const Color error600 = Color(0xFFE53935);
  static const Color error700 = Color(0xFFD32F2F);
  static const Color error800 = Color(0xFFC62828);
  static const Color error900 = Color(0xFFB71C1C);

  // Overlay Colors - Softer variants
  static const Color overlayLight = Color(0x0A000000);
  static const Color overlayVeryLight = Color(0x05000000);
  static const Color overlayMedium = Color(0x14000000);
  static const Color overlayDark = Color(0x33000000);

  // Helper methods for opacity variations
  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: (opacity * 255).round() / 255);
  }

  static Color primaryWithOpacity(double opacity) {
    return primary.withValues(alpha: opacity);
  }

  static Color neutralWithOpacity(double opacity) {
    return neutral.withValues(alpha: opacity);
  }

  static Color shadowWithOpacity(double opacity) {
    return shadowLight.withValues(alpha: opacity);
  }
}
