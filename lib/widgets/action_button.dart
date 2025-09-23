import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;
  final double? size;
  final Color? backgroundColor;
  final Color? borderColor;

  const ActionButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.iconColor,
    this.size,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final buttonSize = size ?? 40;

    return Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(buttonSize / 2),
        border: Border.all(
          color: borderColor ?? AppColors.primary200,
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowVeryLight,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(buttonSize / 2),
          child: Center(
            child: Icon(
              icon,
              color: iconColor ?? AppColors.primary,
              size: buttonSize * 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
