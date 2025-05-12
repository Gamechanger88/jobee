import 'package:flutter/material.dart';
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

class Tag extends StatelessWidget {
  final String text;
  final TagVariant variant;
  final bool compact;

  const Tag({
    super.key,
    required this.text,
    this.variant = TagVariant.defaultTag,
    this.compact = false,
  });

  (Color, Color, BoxBorder?) _getStyles() {
    switch (variant) {
      // Solid variants
      case TagVariant.defaultTag:
        return (AppColors.grey500, AppColors.white, null);
      case TagVariant.info:
        return (AppColors.primary, AppColors.white, null);
      case TagVariant.warning:
        return (AppColors.yellow, AppColors.white, null);
      case TagVariant.error:
        return (AppColors.red, AppColors.white, null);
      case TagVariant.success:
        return (AppColors.green, AppColors.white, null);

      // Outlined variants
      case TagVariant.outlinedDefault:
        return (
          Colors.transparent,
          AppColors.grey500,
          Border.all(color: AppColors.grey500, width: 1),
        );
      case TagVariant.outlinedInfo:
        return (
          Colors.transparent,
          AppColors.primary,
          Border.all(color: AppColors.primary, width: 1),
        );
      case TagVariant.outlinedSuccess:
        return (
          Colors.transparent,
          AppColors.green,
          Border.all(color: AppColors.green, width: 1),
        );
      case TagVariant.outlinedWarning:
        return (
          Colors.transparent,
          AppColors.yellow,
          Border.all(color: AppColors.yellow, width: 1),
        );
      case TagVariant.outlinedError:
        return (
          Colors.transparent,
          AppColors.red,
          Border.all(color: AppColors.red, width: 1),
        );

      // Inverted light variants
      case TagVariant.invertedDefaultLight:
        return (AppColors.grey500.withOpacity(0.08), AppColors.grey500, null);
      case TagVariant.invertedInfoLight:
        return (AppColors.primary.withOpacity(0.08), AppColors.primary, null);
      case TagVariant.invertedSuccessLight:
        return (AppColors.green.withOpacity(0.08), AppColors.green, null);
      case TagVariant.invertedWarningLight:
        return (AppColors.yellow.withOpacity(0.08), AppColors.yellow, null);
      case TagVariant.invertedErrorLight:
        return (AppColors.red.withOpacity(0.08), AppColors.red, null);

      // Inverted dark variants
      case TagVariant.invertedDefaultDark:
        return (AppColors.dark3, AppColors.grey500, null);
      case TagVariant.invertedInfoDark:
        return (AppColors.dark3, AppColors.primary, null);
      case TagVariant.invertedSuccessDark:
        return (AppColors.dark3, AppColors.green, null);
      case TagVariant.invertedWarningDark:
        return (AppColors.dark3, AppColors.yellow, null);
      case TagVariant.invertedErrorDark:
        return (AppColors.dark3, AppColors.red, null);

      // Borderless variants
      case TagVariant.borderlessDefault:
        return (Colors.transparent, AppColors.grey500, null);
      case TagVariant.borderlessInfo:
        return (Colors.transparent, AppColors.primary, null);
      case TagVariant.borderlessSuccess:
        return (Colors.transparent, AppColors.green, null);
      case TagVariant.borderlessWarning:
        return (Colors.transparent, AppColors.yellow, null);
      case TagVariant.borderlessError:
        return (Colors.transparent, AppColors.red, null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final (bgColor, textColor, border) = _getStyles();
    final textStyle = Theme.of(context).textTheme.labelSmall!.copyWith(
      color: textColor,
      fontWeight: FontWeight.w600,
      height: 1.0, // Critical for Figma matching
    );

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 10,
        vertical: compact ? 2 : 4, // Reduced from original 6
      ),
      decoration: BoxDecoration(
        color: bgColor,
        border: border,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: textStyle,
        strutStyle: const StrutStyle(
          forceStrutHeight: true, // Prevents text height fluctuations
          height: 1.0,
        ),
      ),
    );
  }
}
