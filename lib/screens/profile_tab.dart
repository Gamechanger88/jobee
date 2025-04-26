import 'package:flutter/material.dart' as material;
import '../constants/colors.dart';

class ProfileTab extends material.StatelessWidget {
  final material.ThemeMode themeMode;

  const ProfileTab({super.key, this.themeMode = material.ThemeMode.light});

  @override
  material.Widget build(material.BuildContext context) {
    return material.Center(
      child: material.Column(
        mainAxisAlignment: material.MainAxisAlignment.center,
        children: [
          const material.Icon(
            material.Icons.person,
            size: 100,
            color: AppColors.primary,
          ),
          const material.SizedBox(height: 16),
          material.Text(
            'Profile',
            style: material.Theme.of(context).textTheme.headlineLarge?.copyWith(
              color:
                  themeMode == material.ThemeMode.light
                      ? AppColors.black
                      : AppColors.white,
            ),
          ),
          material.Text(
            'View your profile.',
            style: material.Theme.of(context).textTheme.bodyLarge?.copyWith(
              color:
                  themeMode == material.ThemeMode.light
                      ? AppColors.black
                      : AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
