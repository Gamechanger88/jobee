import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({super.key, this.size = 48});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.circle, color: AppColors.primary, size: size),
        const SizedBox(width: 8),
        Text(
          'JOBEE',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(color: AppColors.black),
        ),
      ],
    );
  }
}
