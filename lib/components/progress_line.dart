import 'package:flutter/material.dart' as material;
import '../constants/colors.dart';

class ProgressLine extends material.StatelessWidget {
  final double progress; // Progress value (0.0 to 1.0)
  final String text; // Text to display (e.g., "00/00")
  final material.ThemeMode themeMode; // Light or Dark mode

  const ProgressLine({
    super.key,
    this.progress = 1.0, // Default to 100% progress
    this.text = '00/00', // Default text
    this.themeMode = material.ThemeMode.light, // Default to light mode
  });

  @override
  material.Widget build(material.BuildContext context) {
    final isDarkMode = themeMode == material.ThemeMode.dark;
    final backgroundColor = isDarkMode ? AppColors.dark3 : AppColors.grey200;
    final textColor = isDarkMode ? AppColors.grey200 : AppColors.grey700;

    return material.SizedBox(
      width: double.infinity, // Full width
      child: material.Row(
        children: [
          // Child 1: Progress Bar Container (Expanded)
          material.Expanded(
            child: material.Container(
              height: 8, // Matches progress bar height for hug
              decoration: material.BoxDecoration(
                color:
                    backgroundColor, // Greyscale 200 (light) or Dark 3 (dark)
                borderRadius: material.BorderRadius.circular(
                  100,
                ), // Fully rounded
              ),
              child: material.FractionallySizedBox(
                alignment: material.Alignment.centerLeft,
                widthFactor:
                    progress, // Dynamic width (e.g., 1.0 = full, 0.8 = 80%)
                child: material.Container(
                  height: 8,
                  decoration: material.BoxDecoration(
                    gradient: AppColors.gradientBlue, // Blue gradient
                    borderRadius: material.BorderRadius.circular(
                      100,
                    ), // Fully rounded
                  ),
                ),
              ),
            ),
          ),
          // Spacing: 8px
          const material.SizedBox(width: 8),
          // Child 2: Text
          material.SizedBox(
            width: 56,
            child: material.Text(
              text,
              style: material.Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: material.FontWeight.w500, // Medium
                color:
                    textColor, // Greyscale 700 (light) or Greyscale 200 (dark)
              ),
              textAlign: material.TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
