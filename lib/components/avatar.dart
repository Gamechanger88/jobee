import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AppAvatar extends StatelessWidget {
  final double size;
  final String? imageUrl;

  const AppAvatar({super.key, this.size = 48, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: AppColors.grey400,
      child:
          imageUrl != null
              ? ClipOval(
                child: Image.network(
                  imageUrl!,
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) =>
                          const Icon(Icons.person, color: AppColors.white),
                ),
              )
              : const Icon(Icons.person, color: AppColors.white),
    );
  }
}
