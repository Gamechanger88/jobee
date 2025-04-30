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
          null, // No border
        );
      case TagVariant.invertedInfoLight:
        return (
          AppColors.primary.withOpacity(0.08),
          AppColors.primary,
          null, // No border
        );
      case TagVariant.invertedSuccessLight:
        return (
          AppColors.green.withOpacity(0.08),
          AppColors.green,
          null, // No border
        );
      case TagVariant.invertedWarningLight:
        return (
          AppColors.yellow.withOpacity(0.08),
          AppColors.yellow,
          null, // No border
        );
      case TagVariant.invertedErrorLight:
        return (
          AppColors.red.withOpacity(0.08),
          AppColors.red,
          null, // No border
        );
      // Inverted Dark Style
      case TagVariant.invertedDefaultDark:
        return (
          AppColors.dark3, // 12% transparent dark3
          AppColors.grey500,
          null,
        );
      case TagVariant.invertedInfoDark:
        return (
          AppColors.dark3, // 12% transparent dark3
          AppColors.primary,
          null,
        );
      case TagVariant.invertedSuccessDark:
        return (
          AppColors.dark3, // 12% transparent dark3
          AppColors.green,
          null,
        );
      case TagVariant.invertedWarningDark:
        return (
          AppColors.dark3, // 12% transparent dark3
          AppColors.yellow,
          null,
        );
      case TagVariant.invertedErrorDark:
        return (
          AppColors.dark3, // 12% transparent dark3
          AppColors.red,
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
