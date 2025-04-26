import 'package:flutter/material.dart' as material;
import '../constants/colors.dart';
import '../components/index.dart';

class FindTab extends material.StatelessWidget {
  final material.ThemeMode themeMode;

  const FindTab({super.key, this.themeMode = material.ThemeMode.light});

  @override
  material.Widget build(material.BuildContext context) {
    return material.Center(
      child: material.Column(
        mainAxisAlignment: material.MainAxisAlignment.center,
        children: [
          Search(
            themeMode: themeMode,
            onChanged: (value) {
              // Handle search text changes
            },
            onFilterPressed: () {
              // Add filter logic here
            },
          ),
          const material.SizedBox(height: 16),
          const material.Icon(
            material.Icons.search,
            size: 100,
            color: AppColors.primary,
          ),
          const material.SizedBox(height: 16),
          material.Text(
            'Find Jobs',
            style: material.Theme.of(context).textTheme.headlineLarge?.copyWith(
              color:
                  themeMode == material.ThemeMode.light
                      ? AppColors.black
                      : AppColors.white,
            ),
          ),
          material.Text(
            'Search for opportunities.',
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
