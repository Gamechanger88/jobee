import 'package:flutter/material.dart' as material;
import '../constants/colors.dart';

class SeeAll extends material.StatelessWidget {
  final String title; // e.g., "Recommendation"

  const SeeAll({super.key, required this.title});

  @override
  material.Widget build(material.BuildContext context) {
    return material.Row(
      mainAxisAlignment: material.MainAxisAlignment.spaceBetween,
      children: [
        // First Child: Title Text (e.g., Recommendation)
        material.Expanded(
          child: material.Text(
            title,
            style: material.Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: material.FontWeight.w700, // Bold
              color: AppColors.grey900, // Greyscale 900
            ),
            textAlign: material.TextAlign.left,
          ),
        ),
        // Spacing: 12px
        const material.SizedBox(width: 12),
        // Second Child: See All Text
        material.Text(
          'See All',
          style: material.Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: material.FontWeight.w700, // Bold
            color: AppColors.primary, // Primary Blue
          ),
          textAlign: material.TextAlign.right,
        ),
      ],
    );
  }
}
