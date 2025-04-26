import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AppDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String hint;

  const AppDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: value,
      hint: Text(
        hint,
        style: TextStyle(
          fontSize: 14,
          color: AppColors.grey500,
          fontWeight: FontWeight.w500,
        ),
      ),
      items:
          items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                item.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
      onChanged: onChanged,
      isExpanded: true,
      underline: Container(height: 1, color: AppColors.grey300),
      dropdownColor: AppColors.white,
      icon: const Icon(Icons.arrow_drop_down, color: AppColors.grey500),
    );
  }
}
