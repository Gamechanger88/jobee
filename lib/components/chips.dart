import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AppChips extends StatelessWidget {
  final List<String> labels;
  final List<String> selectedLabels;
  final ValueChanged<String> onSelected;

  const AppChips({
    super.key,
    required this.labels,
    required this.selectedLabels,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children:
          labels.map((label) {
            final isSelected = selectedLabels.contains(label);
            return ChoiceChip(
              label: Text(
                label,
                style: TextStyle(
                  color: isSelected ? AppColors.white : AppColors.grey500,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) => onSelected(label),
              selectedColor: AppColors.primary,
              backgroundColor: AppColors.grey100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: AppColors.grey300),
              ),
            );
          }).toList(),
    );
  }
}
