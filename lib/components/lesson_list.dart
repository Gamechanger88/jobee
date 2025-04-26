import 'package:flutter/material.dart' as material;
import '../constants/colors.dart';

class LessonList extends material.StatelessWidget {
  final String progressText; // Text for progress (e.g., "00")
  final String topicTitle; // Lesson topic title
  final String duration; // Lesson duration
  final List<material.IconData>
  icons; // List of icons (e.g., [Icons.play_arrow])
  final material.ThemeMode themeMode; // Light or Dark mode

  const LessonList({
    super.key,
    this.progressText = '00',
    this.topicTitle = 'Lesson Topic',
    this.duration = 'Duration',
    this.icons = const [material.Icons.play_arrow], // Default to play arrow
    this.themeMode = material.ThemeMode.light, // Default to light mode
  });

  @override
  material.Widget build(material.BuildContext context) {
    final isDarkMode = themeMode == material.ThemeMode.dark;
    final backgroundColor = isDarkMode ? AppColors.dark2 : AppColors.white;
    final topicColor = isDarkMode ? AppColors.white : AppColors.grey900;
    final durationColor = isDarkMode ? AppColors.grey300 : AppColors.grey700;
    final iconColor = isDarkMode ? AppColors.grey400 : AppColors.white;

    return material.Container(
      width: double.infinity, // Fill width
      padding: const material.EdgeInsets.all(16),
      decoration: material.BoxDecoration(
        color: backgroundColor, // White (light) or Dark 2 (dark)
        borderRadius: material.BorderRadius.circular(16), // 16px border radius
        boxShadow: const [
          material.BoxShadow(
            color: material.Color(0x0D04060F), // 04060F at 5% opacity
            offset: material.Offset(0, 4), // x: 0, y: 4
            blurRadius: 60,
            spreadRadius: 0,
          ),
        ],
      ),
      child: material.Row(
        crossAxisAlignment: material.CrossAxisAlignment.center,
        children: [
          // Child 1: Progress Container
          material.Container(
            width: 44,
            height: 44,
            padding: const material.EdgeInsets.all(10),
            decoration: material.BoxDecoration(
              color: AppColors.transparentBlue, // Transparent blue fill
              borderRadius: material.BorderRadius.circular(
                1000,
              ), // Fully rounded
            ),
            child: material.Center(
              child: material.Text(
                progressText,
                style: material.Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(
                  color: AppColors.primary, // Primary blue
                  fontWeight: material.FontWeight.w700, // Bold
                ),
              ),
            ),
          ),
          // Spacing: 16px
          const material.SizedBox(width: 16),
          // Child 2: Lesson Details Container
          material.Expanded(
            child: material.Column(
              mainAxisSize: material.MainAxisSize.min,
              crossAxisAlignment: material.CrossAxisAlignment.start,
              children: [
                // Top Row: Topic Title
                material.Text(
                  topicTitle,
                  style: material.Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(
                    color: topicColor, // Grey 900 (light) or White (dark)
                    fontWeight: material.FontWeight.w700, // Bold
                  ),
                ),
                // Spacing: 6px
                const material.SizedBox(height: 6),
                // Bottom Row: Duration
                material.Text(
                  duration,
                  style: material.Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(
                    color: durationColor, // Grey 700 (light) or Grey 300 (dark)
                    fontWeight: material.FontWeight.w500, // Medium
                  ),
                ),
              ],
            ),
          ),
          // Spacing: 16px
          const material.SizedBox(width: 16),
          // Child 3: Icon Holder
          if (icons.isNotEmpty)
            material.Row(
              mainAxisSize: material.MainAxisSize.min,
              children:
                  icons.asMap().entries.map((entry) {
                    return material.Padding(
                      padding: material.EdgeInsets.only(
                        left: entry.key > 0 ? 8 : 0,
                      ), // 8px spacing between icons
                      child: material.Container(
                        width: 28,
                        height: 28,
                        decoration: material.BoxDecoration(
                          color: AppColors.grey500, // Greyscale 500
                          borderRadius: material.BorderRadius.circular(
                            4,
                          ), // Slight rounding
                        ),
                        child: material.Icon(
                          entry.value,
                          color: iconColor, // White (light) or Grey 400 (dark)
                          size: 20,
                        ),
                      ),
                    );
                  }).toList(),
            ),
        ],
      ),
    );
  }
}
