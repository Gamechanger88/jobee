import 'package:flutter/material.dart';
import '../constants/colors.dart'; // Keep this import as we're using AppColors
import 'button.dart';

class AppModal extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;

  const AppModal({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white, // Background color from Figma Others
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(title, style: Theme.of(context).textTheme.titleLarge),
      content: Text(
        content,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: AppColors.grey500, // Content color from Figma Greyscale
        ),
      ),
      actions: [
        AppButton(
          label: 'Cancel',
          onPressed: () => Navigator.pop(context),
          isDisabled: false,
        ),
        AppButton(label: 'Confirm', onPressed: onConfirm, isDisabled: false),
      ],
    );
  }
}
