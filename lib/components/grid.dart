import 'package:flutter/material.dart';
import '../constants/colors.dart'; // Keep this import as we're using AppColors

class AppGrid extends StatelessWidget {
  final List<Widget> children;

  const AppGrid({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.grey50, // Background color from Figma Greyscale
      padding: const EdgeInsets.all(8),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: children,
      ),
    );
  }
}
