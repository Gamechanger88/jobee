import 'package:flutter/material.dart';
import '../constants/colors.dart';

class Divider extends StatelessWidget {
  final ThemeMode themeMode;

  const Divider({super.key, this.themeMode = ThemeMode.light});

  @override
  Widget build(BuildContext context) {
    final Color color =
        themeMode == ThemeMode.light
            ? AppColors
                .grey200 // Light mode: Greyscale 200
            : AppColors.grey800; // Dark mode: Dark 3 (assumed as grey800)

    return Container(
      width: double.infinity, // Full width of parent
      height: 1, // Standard divider height
      color: color,
    );
  }
}
