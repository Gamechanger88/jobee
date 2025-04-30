import 'package:flutter/material.dart' as material;
import '../constants/colors.dart';
import '../components/index.dart';

class SuppliesTab extends material.StatelessWidget {
  final material.ThemeMode themeMode;

  const SuppliesTab({super.key, this.themeMode = material.ThemeMode.light});

  @override
  material.Widget build(material.BuildContext context) {
    return material.Scaffold(
      // No backgroundColor; defer to main.dart Scaffold background
      body: material.Column(
        children: [
          AppTopBar(
            variant:
                TopBarVariant.iconBack, // Assumed to use iconBack, light mode
            themeMode:
                material.ThemeMode.light, // Force light mode for consistency
            onBackPressed: () {
              material.Navigator.pop(context);
            },
            actions: [
              material.IconButton(
                icon: const material.Icon(
                  material.Icons.search,
                  color: AppColors.white,
                  size: 28,
                ),
                onPressed: () {
                  // TODO: Implement search action
                },
                tooltip: 'Search',
              ),
            ],
            actionVisibilities: [true],
          ),
          // Placeholder content; replace with actual Supplies tab content
          material.Expanded(
            child: material.Center(
              child: material.Text(
                'Supplies Tab Content',
                style: material.TextStyle(
                  color:
                      themeMode == material.ThemeMode.dark
                          ? AppColors.grey200
                          : AppColors.grey900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
