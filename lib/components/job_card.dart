import 'package:flutter/material.dart' as material;
import '../constants/colors.dart';

class JobCard extends material.StatelessWidget {
  const JobCard({super.key});

  @override
  material.Widget build(material.BuildContext context) {
    return material.Container(
      width: 360,
      padding: const material.EdgeInsets.all(20),
      decoration: material.BoxDecoration(
        color: AppColors.grey100, // Grey background for card
        borderRadius: material.BorderRadius.circular(28),
      ),
      child: material.Column(
        mainAxisSize: material.MainAxisSize.min, // Hug height
        crossAxisAlignment: material.CrossAxisAlignment.start,
        children: [
          // First Child: Placeholder Text (Hug height)
          material.Container(
            color: AppColors.grey400, // Grey color for placeholder
            padding: const material.EdgeInsets.all(8),
            child: material.Text(
              'Job Title Placeholder',
              style: material.Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(color: AppColors.white),
            ),
          ),
          // Spacing: 12px
          const material.SizedBox(height: 12),
          // Second Child: Placeholder Text (Hug height)
          material.Container(
            color: AppColors.grey400, // Grey color for placeholder
            padding: const material.EdgeInsets.all(8),
            child: material.Text(
              'Job Description Placeholder\nLine 2 for more content',
              style: material.Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
