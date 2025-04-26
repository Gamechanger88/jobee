import 'package:flutter/material.dart' as material;
import '../constants/colors.dart';

enum TagVariant {
  defaultTag,
  info,
  warning,
  error,
  success,
  outlinedDefault,
  outlinedInfo,
  outlinedSuccess,
  outlinedWarning,
  outlinedError,
  invertedDefaultLight,
  invertedInfoLight,
  invertedSuccessLight,
  invertedWarningLight,
  invertedErrorLight,
  invertedDefaultDark,
  invertedInfoDark,
  invertedSuccessDark,
  invertedWarningDark,
  invertedErrorDark,
  borderlessDefault,
  borderlessInfo,
  borderlessSuccess,
  borderlessWarning,
  borderlessError,
}

class Tag extends material.StatelessWidget {
  final String text; // Tag text
  final TagVariant variant; // Tag variant

  const Tag({
    super.key,
    required this.text,
    this.variant = TagVariant.defaultTag,
  });

  // Get background, text color, and border based on variant
  (
    material.Color backgroundColor,
    material.Color textColor,
    material.BoxBorder? border,
  )
  _getStyles() {
    switch (variant) {
      // Solid Style
      case TagVariant.defaultTag:
        return (AppColors.grey500, AppColors.grey600, null);
      case TagVariant.info:
        return (AppColors.primary, AppColors.white, null);
      case TagVariant.warning:
        return (
          AppColors.yellow,
          AppColors.white,
          null,
        ); // White text temporarily
      case TagVariant.error:
        return (AppColors.red, AppColors.white, null);
      case TagVariant.success:
        return (AppColors.green, AppColors.white, null);
      // Outlined Style
      case TagVariant.outlinedDefault:
        return (
          AppColors.white,
          AppColors.grey500,
          material.Border.all(color: AppColors.grey500, width: 1),
        );
      case TagVariant.outlinedInfo:
        return (
          AppColors.white,
          AppColors.primary,
          material.Border.all(color: AppColors.primary, width: 1),
        );
      case TagVariant.outlinedSuccess:
        return (
          AppColors.white,
          AppColors.green,
          material.Border.all(color: AppColors.green, width: 1),
        );
      case TagVariant.outlinedWarning:
        return (
          AppColors.white,
          AppColors.yellow,
          material.Border.all(color: AppColors.yellow, width: 1),
        );
      case TagVariant.outlinedError:
        return (
          AppColors.white,
          AppColors.red,
          material.Border.all(color: AppColors.red, width: 1),
        );
      // Inverted Light Style
      case TagVariant.invertedDefaultLight:
        return (
          AppColors.grey500.withOpacity(0.08),
          AppColors.grey500,
          material.Border.all(color: AppColors.grey500, width: 1),
        );
      case TagVariant.invertedInfoLight:
        return (
          AppColors.primary.withOpacity(0.08),
          AppColors.primary,
          material.Border.all(color: AppColors.primary, width: 1),
        );
      case TagVariant.invertedSuccessLight:
        return (
          AppColors.green.withOpacity(0.08),
          AppColors.green,
          material.Border.all(color: AppColors.green, width: 1),
        );
      case TagVariant.invertedWarningLight:
        return (
          AppColors.yellow.withOpacity(0.08),
          AppColors.yellow,
          material.Border.all(color: AppColors.yellow, width: 1),
        );
      case TagVariant.invertedErrorLight:
        return (
          AppColors.red.withOpacity(0.08),
          AppColors.red,
          material.Border.all(color: AppColors.red, width: 1),
        );
      // Inverted Dark Style
      case TagVariant.invertedDefaultDark:
      case TagVariant.invertedInfoDark:
      case TagVariant.invertedSuccessDark:
      case TagVariant.invertedWarningDark:
      case TagVariant.invertedErrorDark:
        return (
          const material.Color(0x3D2A2B39), // 24% transparent 2a2b39
          _getTextColorForDark(variant),
          null,
        );
      // Borderless Style
      case TagVariant.borderlessDefault:
        return (AppColors.white, AppColors.grey500, null);
      case TagVariant.borderlessInfo:
        return (AppColors.white, AppColors.primary, null);
      case TagVariant.borderlessSuccess:
        return (AppColors.white, AppColors.green, null);
      case TagVariant.borderlessWarning:
        return (AppColors.white, AppColors.yellow, null);
      case TagVariant.borderlessError:
        return (AppColors.white, AppColors.red, null);
    }
  }

  // Helper to get text color for inverted dark variants
  material.Color _getTextColorForDark(TagVariant variant) {
    switch (variant) {
      case TagVariant.invertedDefaultDark:
        return AppColors.grey500;
      case TagVariant.invertedInfoDark:
        return AppColors.primary;
      case TagVariant.invertedSuccessDark:
        return AppColors.green;
      case TagVariant.invertedWarningDark:
        return AppColors.yellow;
      case TagVariant.invertedErrorDark:
        return AppColors.red;
      default:
        return AppColors.primary; // Fallback
    }
  }

  @override
  material.Widget build(material.BuildContext context) {
    final (backgroundColor, textColor, border) = _getStyles();

    return material.Container(
      padding: const material.EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: material.BoxDecoration(
        color: backgroundColor, // Variant-specific background
        border: border, // Variant-specific border
        borderRadius: material.BorderRadius.circular(6), // 6px border radius
      ),
      child: material.Text(
        text,
        style: material.Theme.of(context).textTheme.labelSmall!.copyWith(
          color: textColor, // Variant-specific text color
          fontWeight: material.FontWeight.w600, // Semibold
        ),
      ),
    );
  }
}
