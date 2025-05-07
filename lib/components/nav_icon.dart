import 'package:flutter/material.dart' as material;
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/colors.dart';

class NavIcon extends material.StatelessWidget {
  final String iconName;
  final bool isActive;

  const NavIcon({super.key, required this.iconName, required this.isActive});

  @override
  material.Widget build(material.BuildContext context) {
    final assetPath = 'assets/icons/${iconName}${isActive ? '_bold' : ''}.svg';
    try {
      return material.Column(
        mainAxisSize: material.MainAxisSize.min,
        children: [
          SvgPicture.asset(
            assetPath,
            width: 24,
            height: 24,
            colorFilter: material.ColorFilter.mode(
              isActive ? AppColors.primary : AppColors.grey400,
              material.BlendMode.srcIn,
            ),
          ),
          const material.SizedBox(height: 6),
        ],
      );
    } catch (e) {
      print('Error loading SVG: $assetPath, $e');
      return material.Column(
        mainAxisSize: material.MainAxisSize.min,
        children: [
          const material.Icon(
            material.Icons.error,
            size: 24,
            color: material.Colors.red,
          ),
          const material.SizedBox(height: 6),
        ],
      );
    }
  }
}
