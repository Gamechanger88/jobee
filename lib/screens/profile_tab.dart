import 'package:flutter/material.dart' as material;
import '../constants/colors.dart';

class ProfileTab extends material.StatelessWidget {
  final material.ThemeMode themeMode;
  final Map<String, dynamic> profile; // Added profile parameter

  const ProfileTab({
    super.key,
    this.themeMode = material.ThemeMode.light,
    required this.profile, // Mark as required to match main.dart usage
  });

  @override
  material.Widget build(material.BuildContext context) {
    return material.Scaffold(
      backgroundColor: AppColors.white,
      appBar: null, // Remove app bar
      body: material.Column(
        children: [
          material.Container(
            width: material.MediaQuery.of(context).size.width,
            height: 44,
            decoration: material.BoxDecoration(
              color: AppColors.white,
              border: material.Border.all(color: AppColors.grey200, width: 1),
            ),
          ),
          // Rest of the page remains empty
        ],
      ),
    );
  }
}
