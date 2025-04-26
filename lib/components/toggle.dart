import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AppToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const AppToggle({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.primary,
      inactiveTrackColor: AppColors.grey300,
    );
  }
}
