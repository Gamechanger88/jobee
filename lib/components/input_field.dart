import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AppInputField extends StatelessWidget {
  final String placeholder;
  final IconData? prefixIcon;
  final bool isPassword;
  final TextEditingController? controller;

  const AppInputField({
    super.key,
    required this.placeholder,
    this.prefixIcon,
    this.isPassword = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: TextStyle(
          fontSize: 14,
          color: AppColors.grey500,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon:
            prefixIcon != null
                ? Icon(prefixIcon, color: AppColors.grey500)
                : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.grey300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.grey300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }
}
